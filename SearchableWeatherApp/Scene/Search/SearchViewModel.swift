//
//  SearchViewModel.swift
//  SearchableWeatherApp
//
//  Created by Y on 2023/01/12.
//

import Foundation

final class SearchViewModel {
    var cityList: CityModel?
    
    internal func filterJson(text: String) {
        decodeJson()
        
        guard let data = cityList else { return }
        cityList = data.filter{ $0.name.hasPrefix(text) || $0.country.hasPrefix(text) }
    }
    
    internal func decodeJson() {
        
        guard let cityData = loadCity() else { return }

        do {
            cityList = try JSONDecoder().decode(CityModel.self, from: cityData)
        } catch {
 
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
    
    internal func requestAPI(indexPath: IndexPath) {
        
        guard let data = cityList else { return }
        
        APIService().requestForecast(lat: data[indexPath.row].coord.lat, lon: data[indexPath.row].coord.lon) { ForecastModel, CurrentWeatherModel in
            let cell = MapCollectionViewCell()
            cell.setCenter()

            let vc = SearchViewController()
            vc.mainView.searchBar.text = ""
        }
    }
    
}
