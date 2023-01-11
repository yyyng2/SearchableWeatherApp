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
    
    convenience init(temp: Double, icon: String, date: Date) {
        self.init()
        self.temp = temp
        self.icon = icon
        self.dt_txt = date
    }
    
}
