//
//  MainViewController.swift
//  SearchableWeatherApp
//
//  Created by Y on 2023/01/11.
//

import UIKit

class MainViewController: UIViewController {
    let mainView = MainView()
    
    override func loadView() {
        self.view = mainView
    }
}
