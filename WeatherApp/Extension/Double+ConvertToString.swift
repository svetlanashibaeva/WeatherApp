//
//  Double+ConvertToString.swift
//  WeatherApp
//
//  Created by Света Шибаева on 19.08.2022.
//

import Foundation

extension Double {
    
    var toString: String {
        return String(format: "%.1f", self)
    }
}
