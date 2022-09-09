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
    
    var weekday: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self)
    }
}
