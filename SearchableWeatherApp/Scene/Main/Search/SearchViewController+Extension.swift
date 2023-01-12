//
//  SearchViewController+Extension.swift
//  SearchableWeatherApp
//
//  Created by Y on 2023/01/12.
//

import UIKit

import RxSwift
import RxCocoa

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return viewModel.cityList?.count ?? 0
       
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCollectionViewCell.reuseIdentifier, for: indexPath) as? SearchCollectionViewCell else { return UICollectionViewCell() }
        
        guard let data = viewModel.cityList else { return cell }
        
        cell.cityLabel.text = data[indexPath.row].name
        cell.countryLabel.text = data[indexPath.row].country
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let data = viewModel.cityList else { return }
        
        networkMoniter()
        APIService().requestForecast(lat: data[indexPath.row].coord.lat, lon: data[indexPath.row].coord.lon) { ForecastModel, CurrentWeatherModel in
            let vc = MainViewController()
            
            
         
            vc.mainView.refresh(refresh: UIRefreshControl())
          
            self.navigationItem.searchController?.searchBar.text = ""
            
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {

            self.dismiss(animated: true)
        })
    }
    
}
