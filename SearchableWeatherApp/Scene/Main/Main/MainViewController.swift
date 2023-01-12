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
        print("mainViewWillAppear",#function)
       
        viewModel.tasks = repository.fetch()
        mainView.collectionView.reloadData()
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        DispatchQueue.main.async {
//            self.networkMoniter()
//            if User.lat == 0.0 {
//                self.viewModel.requestAPI(requestStyle: .firstRequest)
//                print(self.viewModel.currentWeather)
//            } else {
//                if User.city == "" {
//                    self.viewModel.requestAPI(requestStyle: .userRequest)
//                } else {
//                    let time = self.viewModel.compareDate()
//                    if time < -1 {
//                        self.viewModel.requestAPI(requestStyle: .userRequest)
//                        print(self.viewModel.currentWeather)
//                    }
//                }
//                self.viewModel.tasks = self.repository.fetch()
//            }
//        }
    }
    
    override func configure() {
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
    }
    
    override func setNavigation() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: searchBar)
//        self.navigationItem.searchController = mainView.searchBar
        mainView.searchBar.hidesNavigationBarDuringPresentation = true
        
        mainView.searchBar.searchResultsUpdater = self
        
        self.navigationItem.searchController?.searchResultsUpdater = self
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
