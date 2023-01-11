//
//  MainViewModel.swift
//  SearchableWeatherApp
//
//  Created by Y on 2023/01/11.
//

import UIKit

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
            let cell = TimeintervalCollectionViewCell()
            cell.collectionView.reloadData()
            let vc = MainViewController()
            vc.mainView.collectionView.reloadData()
            print("Tasks Changed")
        }
    }
    
    var searchStatus = false
    
    public func compareDate() -> Int {

        let lastUpdateDate = User.lastUpdate.stringFormatToDate()
        
        let date = Date.now.description.replacingOccurrences(of: "+0000", with: "")
        let today = date.stringFormatToDate()
        
        guard let date = Calendar.current.dateComponents([.hour], from: today, to: lastUpdateDate).hour else { return 3 }
        print("compareDateSuccess", date,"today\(today)","last\(lastUpdateDate)")
        return date
    }
    
    public func requestAPI(requestStyle: requestStyle, collectionView: UICollectionView) {
       
        switch requestStyle {
        case .firstRequest:
            APIService().requestForecast(lat: 36.783611, lon: 127.004173) { ForecastModel, CurrentWeatherModel in
                self.currentForecast = ForecastModel
                self.currentWeather = CurrentWeatherModel
             
                collectionView.reloadData()
                let cell = TimeintervalCollectionViewCell()
                cell.collectionView.reloadData()
            }
        case .userRequest:
            APIService().requestForecast(lat: User.userLat, lon: User.userLon) { ForecastModel, CurrentWeatherModel in
                self.currentForecast = ForecastModel
                self.currentWeather = CurrentWeatherModel
                print(self.currentForecast)
                collectionView.reloadData()
                
                let cell = TimeintervalCollectionViewCell()
                cell.collectionView.reloadData()
            }
        }
      
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
