//
//  Date+ConvertToString.swift
//  WeatherApp
//
//  Created by Света Шибаева on 19.08.2022.
//

import Foundation

extension Date {
    
    var hour: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH"
        return dateFormatter.string(from: self)
    }
    
    var day: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.YY"
        return dateFormatter.string(from: self)
    }
    
    var onlyDate: Date? {
        let calender = Calendar.current
        var dateComponents = calender.dateComponents([.year, .month, .day], from: self)
        dateComponents.timeZone = NSTimeZone.system
        return calender.date(from: dateComponents)
    }
    
    var weekday: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self)
    }
}
