//
//  MainViewControllerExtension.swift
//  SearchableWeatherApp
//
//  Created by Y on 2023/01/11.
//

import UIKit

import RxSwift
import RxCocoa

extension MainViewController: UISearchResultsUpdating, UISearchBarDelegate, UISearchControllerDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {

        guard let text = searchController.searchBar.text else {
            return
        }
        
        viewModel.searchStatus = true

        viewModel.city = viewModel.cityList
        
        searchController.searchBar.rx.text.orEmpty
            .distinctUntilChanged()
            .subscribe(onNext: { text in
                self.viewModel.city = self.viewModel.cityList?.filter{ $0.name.hasPrefix(text) || $0.country.hasPrefix(text) }
                self.mainView.collectionView.reloadData()
            })
            .disposed(by: disposeBag)
        
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() // TextField 비활성화
        viewModel.searchStatus = false
        
        self.mainView.collectionView.reloadData()
        return true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.searchStatus = false

        self.mainView.collectionView.reloadData()
      
    }
    
    

}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch viewModel.searchStatus {
        case true:
            switch section {
            case 5:
                return viewModel.city?.count ?? 0
            default:
                return 0
            }
        case false:
            switch section {
            case 5:
                return 0
            default:
                return 1
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.section {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CurrentLocationWeatherCollectionViewCell.reuseIdentifier, for: indexPath) as? CurrentLocationWeatherCollectionViewCell else { return UICollectionViewCell() }
            guard let data = viewModel.currentWeather else { return cell }
                    
            cell.cityLabel.text = "\(data[0].city)"
            cell.tempLabel.text = "\(data[0].temp)°"
            cell.stateLabel.text = "\(data[0].main)"
            cell.maxMinLabel.text = "최고: \(data[0].temp_max)° | 최저: \(data[0].temp_min)°"
            
            return cell
            
        case 1:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TimeintervalCollectionViewCell.reuseIdentifier, for: indexPath) as? TimeintervalCollectionViewCell else { return UICollectionViewCell() }
            guard let data = viewModel.currentWeather else { return cell }
            
            cell.backgroundConfiguration?.cornerRadius = 10
            cell.backgroundView?.layer.cornerRadius = 10
            cell.backgroundView?.clipsToBounds = true
       
            cell.windLabel.text = "돌풍의 풍속은 최대 \(data[0].gust)m/s 입니다."
            
            cell.collectionView.reloadData()
            
            return cell
            
        case 5:
            
            switch viewModel.searchStatus {
                
            case true:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCollectionViewCell.reuseIdentifier, for: indexPath) as? SearchCollectionViewCell else { return UICollectionViewCell() }
                
                guard let data = viewModel.city else { return cell }
                
                cell.cityLabel.text = data[indexPath.row].name
                cell.countryLabel.text = data[indexPath.row].country
                
                return cell
                
            case false:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCollectionViewCell.reuseIdentifier, for: indexPath) as? SearchCollectionViewCell else { return UICollectionViewCell() }
                return cell
            }
            
        default:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCollectionViewCell.reuseIdentifier, for: indexPath) as? SearchCollectionViewCell else { return UICollectionViewCell() }
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}
