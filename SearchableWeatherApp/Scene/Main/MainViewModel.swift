//
//  MainViewModel.swift
//  SearchableWeatherApp
//
//  Created by Y on 2023/01/11.
//

import UIKit
import CoreLocation

import RealmSwift
import RxSwift
import RxCocoa

final class MainViewModel {
    
    var cityList: CityModel?
    
    var city: CityModel?
    
    var currentWeather: [CurrentWeatherModel]?
    
    var currentForecast: [ForecastModel]?
    
    var tasks: Results<Forecast>! {
        didSet {
            let cell = TimeIntervalCollectionViewCell()
            cell.collectionView.reloadData()
            let vc = MainViewController()
            vc.mainView.collectionView.reloadData()
        }
    }
    
    let repository = ForecastRepository()
    
    lazy var isSearching = false
    
    internal func compareDate() -> Int {

        guard let time = Calendar.current.dateComponents([.hour], from: User.lastUpdate, to: Date()).hour else { return 3 }
        print(time, User.lastUpdate, Date())
        return time
    }
    
    internal func requestAPI() {
       
        APIService().requestForecast(lat: User.userLat, lon: User.userLon) { ForecastModel, CurrentWeatherModel in
            self.currentForecast = ForecastModel
            self.currentWeather = CurrentWeatherModel
            
            
            let cell = TimeIntervalCollectionViewCell()
            cell.collectionView.reloadData()
            let mapViewCell = MapCollectionViewCell()
            mapViewCell.setCenter()
        }
      
    }
    
    internal func loadFiveDays() -> [Forecast] {
        let dayOne = repository.fetch()
        let dayTwo = loadDayInfo(dayLater: 1)
        let dayThree = loadDayInfo(dayLater: 2)
        let dayFour = loadDayInfo(dayLater: 3)
        let dayFive = loadDayInfo(dayLater: 4)
        
        let result = [dayOne[0],dayTwo,dayThree,dayFour,dayFive]
        
        let cell = DayIntervalCollectionViewCell()
        cell.collectionView.reloadData()

        return result
    }
    
    private func loadDayInfo(dayLater: Int) -> Forecast {
        let today = Date()
        let dayOne = repository.fetch()
        let dayLater = Calendar.current.date(byAdding: .day, value: dayLater, to: today)
        guard let dayLaterUnwrapped = dayLater!.dateFormatToDate() else { return dayOne[0] }
        let otherDay = repository.fetchFilterDate(date: dayLaterUnwrapped)
        return otherDay[0]
    }
    
}
