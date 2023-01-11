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
        configure()
        setNavigation()
        binding()
    }
    
    internal func configure() { }
    
    internal func setNavigation() { }
    
    internal func binding() { }
    
}
