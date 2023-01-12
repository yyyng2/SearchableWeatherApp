//
//  MainViewController.swift
//  SearchableWeatherApp
//
//  Created by Y on 2023/01/11.
//

import UIKit

import RealmSwift
import RxSwift
import RxCocoa

final class MainViewController: BaseViewController {
    
    let mainView = MainView()
    
    let viewModel = MainViewModel()
    
    let disposeBag = DisposeBag()
    
    let repository = ForecastRepository()
    
    let searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width - 28, height: 0))
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
        viewModel.tasks = repository.fetch()
        viewModel.cellCollectionViewReload()
        mainView.collectionView.reloadData()
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.placeholder = "Search"
    }
    
    override func configure() {
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
    }
    
    override func setNavigation() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: searchBar)
        mainView.searchBar.hidesNavigationBarDuringPresentation = true
        
        self.navigationItem.searchController?.obscuresBackgroundDuringPresentation = false
        self.navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    override func binding() {
        
        searchBar.rx.textDidBeginEditing
            .subscribe(onNext: { [unowned self] in
                let vc = SearchViewController()
                let navi = UINavigationController(rootViewController: vc)
                navi.modalPresentationStyle = .fullScreen
            
                self.present(navi, animated: false)
            })
            .disposed(by: disposeBag)
        
    }
    
}
