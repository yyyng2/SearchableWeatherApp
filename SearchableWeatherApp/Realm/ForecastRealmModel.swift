//
//  ForecastRealmModel.swift
//  SearchableWeatherApp
//
//  Created by Y on 2023/01/11.
//

import UIKit

import RealmSwift

final class Forecast: Object {
    
    private override init() { }

    @Persisted var temp: Double
    @Persisted var icon: String
    @Persisted var dt_txt: String
    
    convenience init(temp: Double, icon: String, dateString: String) {
        self.init()
        self.temp = temp
        self.icon = icon
        self.dt_txt = dateString
    }
    
}
