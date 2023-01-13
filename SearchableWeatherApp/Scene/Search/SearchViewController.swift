//
//  SearchViewController.swift
//  SearchableWeatherApp
//
//  Created by Y on 2023/01/12.
//

import UIKit

import RxSwift
import RxCocoa

final class SearchViewController: BaseViewController {
    let mainView = SearchView()
    
    let viewModel = SearchViewModel()
    
    let disposeBag = DisposeBag()
    
    let swipeGesture = UISwipeGestureRecognizer()
    
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.searchBar.placeholder = "Search"
        DispatchQueue.main.async {
            self.mainView.searchBar.becomeFirstResponder()
        }
    }
    
    override func setNavigation() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: mainView.searchBar)
        self.navigationItem.rightBarButtonItem = mainView.cancelButton
        self.navigationController?.navigationBar.tintColor = .systemGray2

        self.navigationItem.searchController?.obscuresBackgroundDuringPresentation = false
        self.navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    override func configure() {
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
    }
    
    override func binding() {
        
        mainView.cancelButton.rx.tap
            .subscribe(onNext: { [unowned self] in
                self.mainView.searchBar.searchTextField.text = ""
                self.dismiss(animated: false)
            })
            .disposed(by: disposeBag)
        
        mainView.searchBar.searchTextField.rx.text
            .orEmpty
            .distinctUntilChanged()
            .subscribe(onNext: { text in
                guard let text = self.mainView.searchBar.searchTextField.text else { return }
                self.viewModel.filterJson(text: "\(text)")
                self.mainView.collectionView.reloadData()
            })
            .disposed(by: disposeBag)
        
        mainView.collectionView.rx.itemSelected
            .asSignal()
            .emit { [self] indexPath in
                guard let data = viewModel.cityList else { return }
                
                networkMoniter()
                APIService().requestForecast(lat: data[indexPath.row].coord.lat, lon: data[indexPath.row].coord.lon) { ForecastModel, CurrentWeatherModel in
                    print("searchTap")
                    let cell = MapCollectionViewCell()
                    cell.setCenter()
      
                    let vc = SearchViewController()
                    vc.mainView.searchBar.text = ""

                    self.navigationItem.searchController?.searchBar.text = ""
                    
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {

                    self.dismiss(animated: true)
                })
                
            }
            .disposed(by: disposeBag)
        
        mainView.collectionView.rx.willBeginDragging
            .bind(onNext: { value in
                self.mainView.searchBar.endEditing(true)
            })
            .disposed(by: disposeBag)
            
        
        
    }
    
}
