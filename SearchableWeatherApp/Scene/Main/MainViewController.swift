//
//  MainViewController.swift
//  SearchableWeatherApp
//
//  Created by Y on 2023/01/11.
//

import UIKit

class MainViewController: BaseViewController {
    
    let mainView = MainView()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func setNavigation() {
        self.navigationItem.hidesBackButton = true
        self.navigationItem.searchController = mainView.searchBar
    
        self.navigationItem.searchController?.obscuresBackgroundDuringPresentation = false
        self.navigationItem.hidesSearchBarWhenScrolling = false
    }
    
}
