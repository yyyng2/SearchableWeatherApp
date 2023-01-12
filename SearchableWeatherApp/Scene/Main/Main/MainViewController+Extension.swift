//
//  MainViewController+Extension.swift
//  SearchableWeatherApp
//
//  Created by Y on 2023/01/11.
//

import UIKit

import RxSwift
import RxCocoa

extension MainViewController: UISearchResultsUpdating, UISearchBarDelegate, UISearchControllerDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
      


        DispatchQueue.main.async {

//            self.viewModel.decodeJson()
//            self.viewModel.city = self.viewModel.cityList
            
            let vc = SearchViewController()
            vc.mainView.collectionView.reloadData()

            
            searchController.searchBar.rx.text.orEmpty
                .distinctUntilChanged()
                .subscribe(onNext: { text in
                    vc.filterJson(text: text)
                  
                    vc.mainView.collectionView.reloadData()
           
                })
                .disposed(by: self.disposeBag)
        }
    
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() // TextField 비활성화
      
        self.mainView.collectionView.reloadData()
        self.mainView.collectionView.collectionViewLayout.invalidateLayout()
        return true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        DispatchQueue.main.async {
            searchBar.text = ""
            
       
            self.mainView.collectionView.reloadData()
            self.mainView.collectionView.collectionViewLayout.invalidateLayout()
            
            self.dismiss(animated: true)
        }
        self.viewModel.isSearching = false
    }
    
    

}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
    
            return 5
        
//        switch viewModel.isSearching {
//        case true:
//            return 1
//        case false:
//            return 5
//        }
        
      
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
//        switch viewModel.isSearching {
//        case true:
//            return viewModel.city?.count ?? 0
//        case false:
//            return 1
//        }
    
            return 1
        
       
     
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
//        switch viewModel.isSearching {
//        case true:
//            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCollectionViewCell.reuseIdentifier, for: indexPath) as? SearchCollectionViewCell else { return UICollectionViewCell() }
//
//            guard let data = viewModel.city else { return cell }
//
//            cell.cityLabel.text = data[indexPath.row].name
//            cell.countryLabel.text = data[indexPath.row].country
//
//            return cell
//        case false:
//            switch indexPath.section {
//            case 0:
//                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CurrentLocationWeatherCollectionViewCell.reuseIdentifier, for: indexPath) as? CurrentLocationWeatherCollectionViewCell else { return UICollectionViewCell() }
//
//                cell.cityLabel.text = User.city
//                cell.tempLabel.text = "\(Int(User.temp))"
//                cell.stateLabel.text = User.main
//                cell.maxMinLabel.text = "최고: \(Int(User.tempMax))° | 최저: \(Int(User.tempMin))°"
//
//                return cell
//
//            case 1:
//                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TimeIntervalCollectionViewCell.reuseIdentifier, for: indexPath) as? TimeIntervalCollectionViewCell else { return UICollectionViewCell() }
//
//                cell.backgroundConfiguration?.cornerRadius = 10
//                cell.backgroundView?.layer.cornerRadius = 10
//                cell.backgroundView?.clipsToBounds = true
//
//                cell.windLabel.text = "돌풍의 풍속은 최대 \(Int(User.gust))m/s 입니다."
//
//
//                return cell
//
//            case 2:
//                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DayIntervalCollectionViewCell.reuseIdentifier, for: indexPath) as? DayIntervalCollectionViewCell else { return UICollectionViewCell() }
//
//                cell.backgroundConfiguration?.cornerRadius = 10
//                cell.backgroundView?.layer.cornerRadius = 10
//                cell.backgroundView?.clipsToBounds = true
//
//
//
//                return cell
//
//            case 3:
//                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MapCollectionViewCell.reuseIdentifier, for: indexPath) as? MapCollectionViewCell else { return UICollectionViewCell() }
//
//                cell.backgroundConfiguration?.cornerRadius = 10
//                cell.backgroundView?.layer.cornerRadius = 10
//                cell.backgroundView?.clipsToBounds = true
//
//
//
//                return cell
//
//            default:
//                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: QuarteredCollectionViewCell.reuseIdentifier, for: indexPath) as? QuarteredCollectionViewCell else { return UICollectionViewCell() }
//                return cell
//            }
//        }
        
    
            switch indexPath.section {
            case 0:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CurrentLocationWeatherCollectionViewCell.reuseIdentifier, for: indexPath) as? CurrentLocationWeatherCollectionViewCell else { return UICollectionViewCell() }
                
                cell.cityLabel.text = User.city
                cell.tempLabel.text = "\(Int(User.temp))"
                cell.stateLabel.text = User.main
                cell.maxMinLabel.text = "최고: \(Int(User.tempMax))° | 최저: \(Int(User.tempMin))°"
                
                return cell
            case 1:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TimeIntervalCollectionViewCell.reuseIdentifier, for: indexPath) as? TimeIntervalCollectionViewCell else { return UICollectionViewCell() }
                
                cell.backgroundConfiguration?.cornerRadius = 10
                cell.backgroundView?.layer.cornerRadius = 10
                cell.backgroundView?.clipsToBounds = true
                
                cell.windLabel.text = "돌풍의 풍속은 최대 \(Int(User.gust))m/s 입니다."
                
                
                return cell
            case 2:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DayIntervalCollectionViewCell.reuseIdentifier, for: indexPath) as? DayIntervalCollectionViewCell else { return UICollectionViewCell() }
                
                cell.backgroundConfiguration?.cornerRadius = 10
                cell.backgroundView?.layer.cornerRadius = 10
                cell.backgroundView?.clipsToBounds = true
                
                
                
                return cell
            case 3:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MapCollectionViewCell.reuseIdentifier, for: indexPath) as? MapCollectionViewCell else { return UICollectionViewCell() }
                
                cell.backgroundConfiguration?.cornerRadius = 10
                cell.backgroundView?.layer.cornerRadius = 10
                cell.backgroundView?.clipsToBounds = true
                
                
                
                return cell
            default:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: QuarteredCollectionViewCell.reuseIdentifier, for: indexPath) as? QuarteredCollectionViewCell else { return UICollectionViewCell() }
                return cell
               
            }
       
        
    
     
    }
    
   
        //        switch viewModel.isSearching {
        //        case true:
        //
        //            guard let data = viewModel.city else { return }
        //
        //            networkMoniter()
        //            APIService().requestForecast(lat: data[indexPath.row].coord.lat, lon: data[indexPath.row].coord.lon) { ForecastModel, CurrentWeatherModel in
        //
        //                DispatchQueue.main.async {
        //                    self.viewModel.isSearching = false
        //
        //
        //                    collectionView.reloadData()
        //                    collectionView.collectionViewLayout.invalidateLayout()
        //                    self.viewModel.tasks = self.repository.fetch()
        //                    self.navigationItem.searchController?.searchBar.text = ""
        //
        //                    self.dismiss(animated: true)
        //
        //                }
        //
        //                self.viewModel.isSearching = false
        //            }
        //
        //
        //        case false:
        //            break
        //        }
        
        
       
          
        
    
}
