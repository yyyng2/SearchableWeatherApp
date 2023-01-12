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
    
    let searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width - 120, height: 0))
    
    let tapGesture = UITapGestureRecognizer()
    
    let swipeGesture = UISwipeGestureRecognizer()
    
    let cancelButton = UIBarButtonItem(title: "Cancel")
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.placeholder = "Search"
        DispatchQueue.main.async {
          self.searchBar.becomeFirstResponder()
        }
        mainView.addGestureRecognizer(tapGesture)
    }
    
    override func setNavigation() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: searchBar)
        self.navigationItem.rightBarButtonItem = cancelButton
        self.navigationController?.navigationBar.tintColor = .systemGray2

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
                    vc.searchBar.text = ""

                    self.navigationItem.searchController?.searchBar.text = ""
                    
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {

                    self.dismiss(animated: true)
                })
                
            }
            .disposed(by: disposeBag)
        
        mainView.collectionView.rx.willBeginDragging
            .bind(onNext: { value in
                self.searchBar.endEditing(true)
            })
            .disposed(by: disposeBag)
        
        tapGesture.rx.event
            .bind(onNext: { recognizer in
                self.searchBar.endEditing(true)
            })
            .disposed(by: disposeBag)
            
        
        
    }
    
}
