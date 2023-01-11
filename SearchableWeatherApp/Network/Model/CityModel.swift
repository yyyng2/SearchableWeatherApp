//
//  CityModel.swift
//  SearchableWeatherApp
//
//  Created by Y on 2023/01/11.
//

import Foundation

struct CityBase: Codable {
    let id: Int
    let name, country: String
    let coord: Coord
}

struct Coord: Codable {
    let lon, lat: Double
}

typealias CityModel = [CityBase]
