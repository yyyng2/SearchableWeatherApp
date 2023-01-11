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
    
    public func dateFormatToTime() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.autoupdatingCurrent
        dateFormatter.locale = Locale(identifier: "ko_KR")
        
        dateFormatter.dateFormat = "a h"
       
        let string = dateFormatter.string(from: self)
        return string
    }
    
    public func dateFormatToDay() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.autoupdatingCurrent
        dateFormatter.locale = Locale(identifier: "ko_KR")
        
        dateFormatter.dateFormat = "E"
       
        let string = dateFormatter.string(from: self)
        return string
    }
    
    public func dateFormatToDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.autoupdatingCurrent
  
        dateFormatter.dateFormat = "yyyy-MM-dd"
       
        let date = dateFormatter.string(from: self)
        
        let result = date.stringFormatToDateYyyyMmDd() 
        return result
    }
}
