//
//  String+capitalized.swift
//  WeatherApp
//
//  Created by Света Шибаева on 25.08.2022.
//

import Foundation

extension String {
    
    var capitalizingFirstLetter: String {
        return prefix(1).capitalized + dropFirst()
    }
}
