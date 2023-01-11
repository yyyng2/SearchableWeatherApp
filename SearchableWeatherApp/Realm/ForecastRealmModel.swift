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

    @Persisted(primaryKey: true) var objectId: ObjectId
    @Persisted var temp: Double
    @Persisted var icon: String
    @Persisted var dt_txt: Date
    @Persisted var temp_min: Double
    @Persisted var temp_max: Double
    
    convenience init(temp: Double, icon: String, date: Date, temp_max: Double, temp_min: Double) {
        self.init()
        self.temp = temp
        self.icon = icon
        self.dt_txt = date
        self.temp_max = temp_max
        self.temp_min = temp_min
    }
    
}
