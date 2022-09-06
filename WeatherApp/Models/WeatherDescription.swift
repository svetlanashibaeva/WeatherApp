//
//  WeatherDescription.swift
//  WeatherApp
//
//  Created by Света Шибаева on 06.09.2022.
//

import Foundation

struct WeatherDescription: Decodable {
    let main: WeatherStatus
    let description: String
}
