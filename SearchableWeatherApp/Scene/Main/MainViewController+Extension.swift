//
//  MainViewController+Extension.swift
//  SearchableWeatherApp
//
//  Created by Y on 2023/01/11.
//

import UIKit

import RxSwift
import RxCocoa

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 5
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 1
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
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
            
            cell.windLabel.text = "돌풍의 풍속은 최대 \(Int(User.gust))m/s 입니다."
            cell.collectionView.reloadData()
            
            return cell
            
        case 2:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DayIntervalCollectionViewCell.reuseIdentifier, for: indexPath) as? DayIntervalCollectionViewCell else { return UICollectionViewCell() }
            
            cell.collectionView.reloadData()
            
            return cell
            
        case 3:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MapCollectionViewCell.reuseIdentifier, for: indexPath) as? MapCollectionViewCell else { return UICollectionViewCell() }
            

            cell.setCenter()
            
            return cell
            
        default:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: QuarteredCollectionViewCell.reuseIdentifier, for: indexPath) as? QuarteredCollectionViewCell else { return UICollectionViewCell() }
            
            cell.collectionView.reloadData()
            
            return cell
            
        }
        
        
        
        
    }
    
}
