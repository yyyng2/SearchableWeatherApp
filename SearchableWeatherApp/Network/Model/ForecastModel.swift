//
//  ForecastModel.swift
//  SearchableWeatherApp
//
//  Created by Y on 2023/01/11.
//

import Foundation

struct ForecastModel: Codable {
    let temp, temp_min, temp_max: Double
    let icon: String
    let dt_txt: Date
}
