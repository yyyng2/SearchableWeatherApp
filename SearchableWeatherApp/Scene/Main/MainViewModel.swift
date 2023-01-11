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

class MainViewModel {
    
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
            print("Tasks Changed")
        }
    }
    
    let repository = ForecastRepository()
    
    lazy var isSearching = false
    
    public func compareDate() -> Int {

        guard let date = Calendar.current.dateComponents([.hour], from: Date(), to: User.lastUpdate).hour else { return 3 }
        print("compareDateSuccess", date,"today\(Date())","last\(User.lastUpdate)")
        return date
    }
    
    public func requestAPI(requestStyle: requestStyle, collectionView: UICollectionView) {
       
        switch requestStyle {
        case .firstRequest:
            APIService().requestForecast(lat: 36.783611, lon: 127.004173) { ForecastModel, CurrentWeatherModel in
                self.currentForecast = ForecastModel
                self.currentWeather = CurrentWeatherModel
             
                collectionView.reloadData()
                let cell = TimeIntervalCollectionViewCell()
                cell.collectionView.reloadData()
                let mapViewCell = MapCollectionViewCell()
                mapViewCell.setCenter()
            }
        case .userRequest:
            APIService().requestForecast(lat: User.userLat, lon: User.userLon) { ForecastModel, CurrentWeatherModel in
                self.currentForecast = ForecastModel
                self.currentWeather = CurrentWeatherModel
                print(self.currentForecast)
                collectionView.reloadData()
                
                let cell = TimeIntervalCollectionViewCell()
                cell.collectionView.reloadData()
                let mapViewCell = MapCollectionViewCell()
                mapViewCell.setCenter()
            }
        }
      
    }
    
    public func loadFiveDays() -> [Forecast] {
        let today = Date()
        let dayOne = repository.fetch()
        let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: today)
        guard let tomorrowUnwrapped = tomorrow!.dateFormatToDate() else { return [dayOne[0]] }
        let dayTwo = repository.fetchFilterDate(date: tomorrowUnwrapped)
        let twoDaysLater = Calendar.current.date(byAdding: .day, value: 2, to: today)
        guard let twoDaysLaterUnwrapped = twoDaysLater!.dateFormatToDate() else { return [dayOne[0]] }
        let dayThree = repository.fetchFilterDate(date: twoDaysLaterUnwrapped)
        let threeDaysLater = Calendar.current.date(byAdding: .day, value: 3, to: today)
        guard let threeDaysLaterUnwrapped = threeDaysLater!.dateFormatToDate() else { return [dayOne[0]] }
        let dayFour = repository.fetchFilterDate(date: threeDaysLaterUnwrapped)
        let fourDaysLater = Calendar.current.date(byAdding: .day, value: 4, to: today)
        guard let fourDaysLaterUnwrapped = fourDaysLater!.dateFormatToDate() else { return [dayOne[0]] }
        let dayFive = repository.fetchFilterDate(date: fourDaysLaterUnwrapped)
        
        let result = [dayOne[0],dayTwo[0],dayThree[0],dayFour[0],dayFive[0]]
        
        let cell = DayIntervalCollectionViewCell()
        cell.collectionView.reloadData()
        print(result)
        return result
    }
    
    public func decodeJson() {
        guard let cityData = loadCity() else { return }
        print("cityDataSuccess")
        print(cityData)
        do {
            cityList = try JSONDecoder().decode(CityModel.self, from: cityData)
            print("cityListSuccess")
            guard let cityOne = cityList?[0] else { return }
            print(cityOne.coord)
        } catch {
            print("cityListError")
        }
    }
    
    private func loadCity() -> Data? {
        let fileName = "CityList"
        let fileType = "json"
        
        guard let path = Bundle.main.url(forResource: fileName, withExtension: fileType) else {
            print("pathError")
            return nil
        }
        print("pathSuccess")
        
        do {
            let data = try Data(contentsOf: path)
            print("cityListSuccess")
            return data
        } catch {
            print("cityListError")
            return nil
        }
    }
   
}

extension MainViewModel {
    enum requestStyle {
        case userRequest
        case firstRequest
    }
}
