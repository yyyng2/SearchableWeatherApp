//
//  BaseViewController.swift
//  SearchableWeatherApp
//
//  Created by Y on 2023/01/11.
//

import UIKit

class BaseViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigation()
        binding()
    }
    
    func setNavigation() { }
    
    func binding() { }
}
