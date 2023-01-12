//
//  SearchViewController.swift
//  SearchableWeatherApp
//
//  Created by Y on 2023/01/12.
//

import UIKit

import RxSwift
import RxCocoa

class SearchViewController: BaseViewController {
    let mainView = SearchView()
    
    let viewModel = SearchViewModel()
    
    let disposeBag = DisposeBag()
    
    let searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width - 120, height: 0))
    
    let cancelButton = UIBarButtonItem(title: "Cancel")
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.filterJson(text: "")
        searchBar.placeholder = "Search"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print(#function)
        let vc = MainViewController()
        vc.mainView.collectionView.reloadData()
    }
    
    override func setNavigation() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: searchBar)
        self.navigationItem.rightBarButtonItem = cancelButton
        self.navigationController?.navigationBar.tintColor = .systemGray2
//        searchBar.setValue("Cancel", forKey: "cancelButtonText")
//        searchBar.tintColor = .systemGray2

        self.navigationItem.searchController?.obscuresBackgroundDuringPresentation = false
        self.navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    override func configure() {
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
    }
    
    override func binding() {
        
        cancelButton.rx.tap
            .subscribe(onNext: { [unowned self] in
                self.searchBar.searchTextField.text = ""
                self.dismiss(animated: false)
            })
            .disposed(by: disposeBag)
        
        searchBar.searchTextField.rx.text
            .orEmpty
            .distinctUntilChanged()
            .subscribe(onNext: { text in
                guard let text = self.searchBar.searchTextField.text else { return }
                self.viewModel.filterJson(text: "\(text)")
                self.mainView.collectionView.reloadData()
            })
            .disposed(by: disposeBag)
        
        
     
    }
    
  
    
}
