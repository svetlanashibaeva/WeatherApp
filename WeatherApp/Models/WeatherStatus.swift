//
//  WeatherStatus.swift
//  WeatherApp
//
//  Created by Света Шибаева on 06.09.2022.
//

import Foundation

enum WeatherStatus: String, Decodable {
    case thunderstorm = "Thunderstorm"
    case drizzle = "Drizzle"
    case rain = "Rain"
    case snow = "Snow"
    case mist = "Mist"
    case smoke = "Smoke"
    case haze = "Haze"
    case dust = "Dust"
    case fog = "Fog"
    case sand = "Sand"
    case ash = "Ash"
    case squall = "Squall"
    case tornado = "Tornado"
    case clear = "Clear"
    case clouds = "Clouds"
    
    var imageName: String {
        switch self {
        case .thunderstorm:
            return "cloud.bolt.rain.fill"
        case .drizzle, .rain:
            return "cloud.rain.fill"
        case .snow:
           return "snowflake"
        case .mist, .smoke, .haze, .dust, .fog, .sand, .ash, .squall, .tornado:
            return "cloud.fog.fill"
        case .clear:
            return "sun.max.fill"
        case .clouds:
            return "cloud.fill"
        }
    }
}
