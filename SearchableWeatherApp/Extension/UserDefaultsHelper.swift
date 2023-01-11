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
}

struct User {
    @UserDefaultsHelper(key: keyEnum.userLat.rawValue, defaultValue: 0.0)
    static var userLat: Double
    @UserDefaultsHelper(key: keyEnum.userLon.rawValue, defaultValue: 0.0)
    static var userLon: Double
    @UserDefaultsHelper(key: keyEnum.lastUpdate.rawValue, defaultValue: "")
    static var lastUpdate: String
}
