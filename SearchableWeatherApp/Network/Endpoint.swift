//
//  Endpoint.swift
//  SearchableWeatherApp
//
//  Created by Y on 2023/01/11.
//

import Foundation

import Alamofire

enum WeatherAPI {
    case request(lat: Double, lon: Double, appid: String, units: String)
    case reqeustForecast(lat: Double, lon: Double, appid: String, units: String)
}

extension WeatherAPI {
    var baseURL: String {
        return "https://api.openweathermap.org/data/2.5/weather?"
    }
    
    var forecastURL: String {
        return "https://api.openweathermap.org/data/2.5/forecast?"
    }
                   
    var path: URL {
        switch self {
        case .request:
            return URL(string: baseURL)!
        case .reqeustForecast:
            return URL(string: forecastURL)!
        }
    }
    
    var parameters: [String: Any] {
        switch self {
        case .request(let lat, let lon, let appid, let units):
            return [
                "lat" : lat,
                "lon" : lon,
                "appid" : appid,
                "units" : units
            ]
        case .reqeustForecast(let lat, let lon, let appid, let units):
            return [
                "lat" : lat,
                "lon" : lon,
                "appid" : appid,
                "units" : units
            ]
        }
    }
    
}
