//
//  CurrentWeatherModel.swift
//  SearchableWeatherApp
//
//  Created by Y on 2023/01/11.
//

import Foundation

struct CurrentWeatherModel: Codable {
    let pressure, humidity, clouds: Int
    let temp, lat, lon, speed, gust, temp_min, temp_max: Double
    let city, description, main: String
}
