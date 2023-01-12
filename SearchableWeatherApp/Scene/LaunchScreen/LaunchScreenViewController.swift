//
//  LaunchScreenViewController.swift
//  SearchableWeatherApp
//
//  Created by Y on 2023/01/12.
//

import UIKit

class LaunchScreenViewController: BaseViewController {
    
    let viewModel = MainViewModel()
    
    let repository = ForecastRepository()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        view.backgroundColor = Constants.BaseColor.backgroundColor
        loadData()
    }
    
    private func loadData() {
        self.networkMoniter()
        if User.lat == 0.0 {
            viewModel.requestAPI(requestStyle: .firstRequest)
        } else {
            if User.city == "" {
                self.viewModel.requestAPI(requestStyle: .userRequest)
            } else {
                let time = self.viewModel.compareDate()
                if time < -1 {
                    self.viewModel.requestAPI(requestStyle: .userRequest)
                }
            }
            self.viewModel.tasks = self.repository.fetch()
        }
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.5) {
            let vc = MainViewController()
            let navi = UINavigationController(rootViewController: vc)
            navi.modalPresentationStyle = .overFullScreen
            
            self.present(navi, animated: false)
        }
    }
    
}
