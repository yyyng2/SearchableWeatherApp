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
        
        viewModel.isSearching = true

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
        searchState = false
        
        self.mainView.collectionView.reloadData()
        return true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        
        viewModel.isSearching = false
        viewModel.city = []
        viewModel.tasks = repository.fetch()
        mainView.collectionView.reloadData()
        
        self.dismiss(animated: true)
      
    }
    
    

}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        switch viewModel.isSearching {
        case true:
            return 1
        case false:
            return 5
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch viewModel.isSearching {
        case true:
            return viewModel.city?.count ?? 0
        case false:
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch viewModel.isSearching {
        case true:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCollectionViewCell.reuseIdentifier, for: indexPath) as? SearchCollectionViewCell else { return UICollectionViewCell() }
            
            guard let data = viewModel.city else { return cell }
            
            cell.cityLabel.text = data[indexPath.row].name
            cell.countryLabel.text = data[indexPath.row].country
            
            return cell
        case false:
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
                
                cell.collectionView.reloadData()
                
                return cell
                
            case 2:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DayIntervalCollectionViewCell.reuseIdentifier, for: indexPath) as? DayIntervalCollectionViewCell else { return UICollectionViewCell() }
                
                cell.backgroundConfiguration?.cornerRadius = 10
                cell.backgroundView?.layer.cornerRadius = 10
                cell.backgroundView?.clipsToBounds = true

                
                cell.collectionView.reloadData()
                
                return cell
                
                
            default:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CurrentLocationWeatherCollectionViewCell.reuseIdentifier, for: indexPath) as? CurrentLocationWeatherCollectionViewCell else { return UICollectionViewCell() }
                return cell
            }
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch viewModel.isSearching {
        case true:
                
            guard let data = viewModel.city else { return }
            
            networkMoniter()
            APIService().requestForecast(lat: data[indexPath.row].coord.lat, lon: data[indexPath.row].coord.lon) { ForecastModel, CurrentWeatherModel in
                
                self.viewModel.isSearching = false
                self.viewModel.city?.removeAll()
                collectionView.reloadData()
                self.viewModel.tasks = self.repository.fetch()
                self.dismiss(animated: true)
          
                
                self.navigationItem.searchController?.searchBar.text = ""
                
            }
            
        case false:
            break
        }
      
    }
    
}
