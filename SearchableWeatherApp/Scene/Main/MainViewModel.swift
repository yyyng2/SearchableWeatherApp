//
//  MainViewModel.swift
//  SearchableWeatherApp
//
//  Created by Y on 2023/01/11.
//

import UIKit

import RxSwift
import RxCocoa

class MainViewModel {
    
    var cityList: CityModel?
    
    var city: CityModel?
    
    var currentWeather: [CurrentWeatherModel]?
    
    var currentForecast: [ForecastModel]?
    
//    var searchStatus: BehaviorRelay<Bool> = BehaviorRelay(value: false)
    var searchStatus = false
    
    public func requestAPI(requestStyle: requestStyle, collectionView: UICollectionView) {
       
        switch requestStyle {
        case .firstRequest:
//            APIService().requestWeather(lat: 37.43861, lon: 127.137779) { response in
//                print(response.value)
//                switch response.result {
//
//                case .success(let result):
//                    self.currentWeather = result
//                    print(result)
//                    collectionView.reloadData()
//                case .failure(let error):
//                    print(error)
//                }
//            }
            APIService().requestForecast(lat: 37.43861, lon: 127.137779) { ForecastModel, CurrentWeatherModel in
                self.currentForecast = ForecastModel
                self.currentWeather = CurrentWeatherModel
                print("currentForecast", CurrentWeatherModel)
                collectionView.reloadData()
            }
        case .userRequest:
//            APIService().requestWeather(lat: User.userLat, lon: User.userLon) { response in
//                switch response.result {
//                case .success(let result):
//                    self.currentWeather = result
//                    print(result)
//                    collectionView.reloadData()
//                case .failure(let error):
//                    print(error)
//                }
//            }
            APIService().requestForecast(lat: User.userLat, lon: User.userLon) { ForecastModel, CurrentWeatherModel in
                self.currentForecast = ForecastModel
                self.currentWeather = CurrentWeatherModel
                print("currentForecast", CurrentWeatherModel)
                collectionView.reloadData()
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
