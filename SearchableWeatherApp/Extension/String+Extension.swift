//
//  String+Extension.swift
//  SearchableWeatherApp
//
//  Created by Y on 2023/01/11.
//

import Foundation

extension String {
    func stringFormatToDate() -> Date {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
       
        guard let date = dateFormatter.date(from: self) else {
            return Date() }
        return date
    }
    
    func stringFormatToTime() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.autoupdatingCurrent
        dateFormatter.locale = Locale.current
     
  
        dateFormatter.dateFormat = "HH"
       
        let date = dateFormatter.date(from: self)
        return date
    }
    
    func stringFormatToDay() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.autoupdatingCurrent
        dateFormatter.locale = Locale.current
     
  
        dateFormatter.dateFormat = "E"
       
        let date = dateFormatter.date(from: self)
        return date
    }
    
    func stringFormatToDateYyyyMmDd() -> Date {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "yyyy-MM-dd"
       
        guard let date = dateFormatter.date(from: self) else {
            return Date() }
        return date
    }
    
}
