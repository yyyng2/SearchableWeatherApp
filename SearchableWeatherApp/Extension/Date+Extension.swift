//
//  Date+Extension.swift
//  SearchableWeatherApp
//
//  Created by Y on 2023/01/11.
//

import Foundation

extension Date {
    public func dateFormatToString() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.autoupdatingCurrent
  
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
       
        let string = dateFormatter.string(from: self)
        return string
    }
}
