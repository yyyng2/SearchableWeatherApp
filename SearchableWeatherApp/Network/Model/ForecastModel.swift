//
//  ForecastModel.swift
//  SearchableWeatherApp
//
//  Created by Y on 2023/01/11.
//

import Foundation

struct ForecastModel: Codable {
    let temp: Double
    let icon, dt_txt: String
}
