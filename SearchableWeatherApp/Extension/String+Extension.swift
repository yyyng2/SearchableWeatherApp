//
//  String+Extension.swift
//  SearchableWeatherApp
//
//  Created by Y on 2023/01/11.
//

import Foundation

extension String {
    public func stringFormatToDate() -> Date {
        let dateFormatter = DateFormatter()
      //  dateFormatter.timeZone = TimeZone.autoupdatingCurrent
        
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
       
        guard let date = dateFormatter.date(from: self) else {
            print("stringFormatToDateError")
            return Date() }
        return date
    }
    
    public func stringFormatToTime() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.autoupdatingCurrent
        dateFormatter.locale = Locale.current
     
  
        dateFormatter.dateFormat = "a hh:mm"
       
        let date = dateFormatter.date(from: self)
        return date
    }
    
    public func stringFormatToDay() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.autoupdatingCurrent
        dateFormatter.locale = Locale.current
     
  
        dateFormatter.dateFormat = "E"
       
        let date = dateFormatter.date(from: self)
        return date
    }
    
}
