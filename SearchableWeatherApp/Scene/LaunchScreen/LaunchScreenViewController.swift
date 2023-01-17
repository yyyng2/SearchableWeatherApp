//
//  LaunchScreenViewController.swift
//  SearchableWeatherApp
//
//  Created by Y on 2023/01/12.
//

import UIKit

final class LaunchScreenViewController: BaseViewController {
    
    private let viewModel = MainViewModel()
    
    private let repository = ForecastRepository()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        view.backgroundColor = Constants.BaseColor.backgroundColor
        loadData()
    }
    
    private func loadData() {
        
        networkMoniter()

        switch User.isFirstLaunch {
        case true:
            User.isFirstLaunch = !User.isFirstLaunch
            viewModel.requestAPI()
            presentView(time: 1.5)
        case false:
            let time = viewModel.compareDate()
            if time > 1 {
                viewModel.requestAPI()
                presentView(time: 1.5)
            } else {
                presentView(time: 0)
            }
        }
       
    }
    
    private func presentView(time: Double) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + time) {
            let searchVM = SearchViewModel()
            searchVM.decodeJson()

            let vc = MainViewController()
            let navi = UINavigationController(rootViewController: vc)
            navi.modalPresentationStyle = .overFullScreen
            
            self.present(navi, animated: false)
        }
    }
    
}
