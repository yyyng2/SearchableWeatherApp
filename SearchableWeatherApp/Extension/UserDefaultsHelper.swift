//
//  UserDefaultsHelper.swift
//  SearchableWeatherApp
//
//  Created by Y on 2023/01/11.
//

import Foundation

@propertyWrapper struct UserDefaultsHelper<T> {
    
    private var key: String
    private let defaultValue: T
  
    init(key: String, defaultValue: T) {
          self.key = key
          self.defaultValue = defaultValue
      }
    
    var wrappedValue: T {
        get {
            return UserDefaults.standard.object(forKey: key) as? T ?? defaultValue
        }
        set {
            UserDefaults.standard.set(newValue, forKey: key)
        }
    }

}

enum keyEnum: String {
    case userLat = "userLat"
    case userLon = "userLon"
    case lastUpdate = "lastUpdate"
    case city = "city"
    case temp = "temp"
    case main = "main"
    case tempMax = "tempMax"
    case tempMin = "tempMin"
    case pressure = "pressure"
    case humidity = "humidity"
    case clouds = "clouds"
    case lat = "lat"
    case lon = "lon"
    case speed = "speed"
    case gust = "gust"
}

struct User {
    @UserDefaultsHelper(key: keyEnum.userLat.rawValue, defaultValue: 0.0)
    static var userLat: Double
    @UserDefaultsHelper(key: keyEnum.userLon.rawValue, defaultValue: 0.0)
    static var userLon: Double
    @UserDefaultsHelper(key: keyEnum.lastUpdate.rawValue, defaultValue: Date())
    static var lastUpdate: Date
    @UserDefaultsHelper(key: keyEnum.city.rawValue, defaultValue: "")
    static var city: String
    @UserDefaultsHelper(key: keyEnum.temp.rawValue, defaultValue: 0.0)
    static var temp: Double
    @UserDefaultsHelper(key: keyEnum.main.rawValue, defaultValue: "")
    static var main: String
    @UserDefaultsHelper(key: keyEnum.tempMax.rawValue, defaultValue: 0.0)
    static var tempMax: Double
    @UserDefaultsHelper(key: keyEnum.tempMin.rawValue, defaultValue: 0.0)
    static var tempMin: Double
    @UserDefaultsHelper(key: keyEnum.pressure.rawValue, defaultValue: 0)
    static var pressure: Int
    @UserDefaultsHelper(key: keyEnum.humidity.rawValue, defaultValue: 0)
    static var humidity: Int
    @UserDefaultsHelper(key: keyEnum.clouds.rawValue, defaultValue: 0)
    static var clouds: Int
    @UserDefaultsHelper(key: keyEnum.lat.rawValue, defaultValue: 0.0)
    static var lat: Double
    @UserDefaultsHelper(key: keyEnum.lon.rawValue, defaultValue: 0.0)
    static var lon: Double
    @UserDefaultsHelper(key: keyEnum.speed.rawValue, defaultValue: 0.0)
    static var speed: Double
    @UserDefaultsHelper(key: keyEnum.gust.rawValue, defaultValue: 0.0)
    static var gust: Double
}
