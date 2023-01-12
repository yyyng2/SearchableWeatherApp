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
    
    let searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width - 28, height: 0))
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print(#function)
        let vc = MainViewController()
        vc.mainView.collectionView.reloadData()
    }
    
    override func setNavigation() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: searchBar)
        searchBar.setValue("Cancel", forKey: "cancelButtonText")
        searchBar.tintColor = .systemGray2

        mainView.searchBar.searchResultsUpdater = self
        self.navigationItem.searchController?.obscuresBackgroundDuringPresentation = false
        self.navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    override func configure() {
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
        searchBar.delegate = self
    }
    
    override func binding() {
        viewModel.filterJson(text: "")
        
        searchBar.rx.textDidBeginEditing
            .subscribe(onNext: { [unowned self] in
                self.searchBar.setShowsCancelButton(true, animated: true)
                
                guard let text = self.searchBar.searchTextField.text else { return }
                self.viewModel.filterJson(text: "\(text)")
                self.mainView.collectionView.reloadData()
                
            })
            .disposed(by: disposeBag)
        
        searchBar.rx.cancelButtonClicked
            .subscribe(onNext: { [unowned self] in
                self.searchBar.searchTextField.text = ""
                self.dismiss(animated: false)
            })
            .disposed(by: disposeBag)
        
//        searchBar.searchTextField.rx.value.changed
//            .subscribe { _ in
//                let vc = SearchViewController()
//                let text = self.searchBar.searchTextField.text!
//                vc.viewModel.filterJson(text: text)
//            }
//            .disposed(by: disposeBag)
        
     
    }
    
  
    
}
