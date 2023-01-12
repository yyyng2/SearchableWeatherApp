//
//  QuarteredInfo.swift
//  SearchableWeatherApp
//
//  Created by Y on 2023/01/12.
//

import Foundation

struct Quarter {
    let description: String
    let value: String
    let gust: String
}

struct QuarteredInfo {
    let quarterInfo: [Quarter] = [
        Quarter(description: "바람 속도", value: "\(User.speed)m/s", gust: "강풍: \(User.gust)m/s"),
        Quarter(description: "습도", value: "\(User.humidity)%", gust: ""),
        Quarter(description: "구름", value: "\(User.clouds)%", gust: ""),
        Quarter(description: "기압", value: "\(User.pressure)hpa", gust: "")
        ]
}
