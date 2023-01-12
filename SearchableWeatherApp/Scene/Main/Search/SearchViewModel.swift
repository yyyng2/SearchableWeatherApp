//
//  SearchViewModel.swift
//  SearchableWeatherApp
//
//  Created by Y on 2023/01/12.
//

import Foundation

final class SearchViewModel {
    var cityList: CityModel?
    
    public func filterJson(text: String) {
        decodeJson()
        
        guard let data = cityList else { return }
        cityList = data.filter{ $0.name.hasPrefix(text) || $0.country.hasPrefix(text) }
    }
    
    private func decodeJson() {
        loadCity()
        
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
