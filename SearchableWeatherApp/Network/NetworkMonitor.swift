//
//  NetworkMonitor.swift
//  SearchableWeatherApp
//
//  Created by Y on 2023/01/11.
//

import UIKit
import Network

extension UIViewController {
    func networkMoniter() {
        let monitor = NWPathMonitor()
        
        monitor.pathUpdateHandler = {
            path in
            if path.status == .satisfied {
                DispatchQueue.main.async {
                    return
                }
            } else {
                DispatchQueue.main.async { [unowned self] in
                    showRequestNetworkServiceAlert()
                }
            }
        }
        let queue = DispatchQueue(label: "Network")
        monitor.start(queue: queue)
    }
    
    func showRequestNetworkServiceAlert() {
        let requestLocationServiceAlert = UIAlertController(title: "설정으로 이동", message: "네트워크를 사용할 수 없습니다. 기기의 설정에서 네트워크 상태를 확인해 주세요.", preferredStyle: .alert)
        let goSetting = UIAlertAction(title: "설정으로 이동", style: .destructive) { _ in
            if let appSetting = URL(string: UIApplication.openSettingsURLString){
                UIApplication.shared.open(appSetting)
            }
        }
        let cancel = UIAlertAction(title: "취소", style: .default)
        requestLocationServiceAlert.addAction(cancel)
        requestLocationServiceAlert.addAction(goSetting)
        
        self.present(requestLocationServiceAlert, animated: true, completion: nil)
    }
}
