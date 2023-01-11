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

class MainViewController: BaseViewController {
    
    let mainView = MainView()
    
    let viewModel = MainViewModel()
    
    let disposeBag = DisposeBag()
    
    let repository = ForecastRepository()    
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.async {
            self.networkMoniter()
            if User.lat == 0.0 {
                self.viewModel.requestAPI(requestStyle: .firstRequest, collectionView: self.mainView.collectionView)
                print(self.viewModel.currentWeather)
            } else {
                if User.city == "" {
                    self.viewModel.requestAPI(requestStyle: .userRequest, collectionView: self.mainView.collectionView)
                } else {
                    let time = self.viewModel.compareDate()
                    if time < -1 {
                        self.viewModel.requestAPI(requestStyle: .userRequest, collectionView: self.mainView.collectionView)
                        print(self.viewModel.currentWeather)
                    }
                }
                self.viewModel.tasks = self.repository.fetch()
            }
        }
      
    }
    
    override func configure() {
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
        mainView.searchBar.delegate = self
    }
    
    override func setNavigation() {
        self.navigationItem.searchController = mainView.searchBar
        self.navigationItem.searchController?.searchResultsUpdater = self
        self.navigationItem.searchController?.obscuresBackgroundDuringPresentation = false
        self.navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    override func binding() {
        viewModel.decodeJson()
        
      
    
          
    }
    
}
