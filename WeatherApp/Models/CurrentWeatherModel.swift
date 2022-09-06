//
//  CurrentWeatherModel.swift
//  WeatherApp
//
//  Created by Света Шибаева on 18.08.2022.
//

import Foundation

struct CurrentWeather: Decodable {
    let coord: Coordinate
    let weather: [WeatherDescription]
    let main: MainWeather
    let name: String
}
