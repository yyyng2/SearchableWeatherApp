//
//  MainViewController.swift
//  SearchableWeatherApp
//
//  Created by Y on 2023/01/11.
//

import UIKit

import RxSwift
import RxCocoa

final class MainViewController: BaseViewController {
    
    let mainView = MainView()
    
    let viewModel = MainViewModel()
    
    let disposeBag = DisposeBag()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
        viewModel.tasks = viewModel.repository.fetch()
        mainView.collectionView.reloadData()
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.searchBar.placeholder = "Search"
    }
    
    override func configure() {
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
    }
    
    override func setNavigation() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: mainView.searchBar)
        
        self.navigationItem.searchController?.obscuresBackgroundDuringPresentation = false
        self.navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    override func binding() {
        
        mainView.searchBar.rx.textDidBeginEditing
            .subscribe(onNext: { [unowned self] in
                let vc = SearchViewController()
                let navi = UINavigationController(rootViewController: vc)
                navi.modalPresentationStyle = .fullScreen
            
                self.present(navi, animated: false)
            })
            .disposed(by: disposeBag)
        
    }
    
}
