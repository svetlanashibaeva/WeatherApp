//
//  CurrentWeatherModel.swift
//  WeatherApp
//
//  Created by Света Шибаева on 18.08.2022.
//

import Foundation

struct CurrentWeather: Decodable {
    let coord: Coordinate
    let weather: [Weather]
    let main: MainWeather
    let name: String
}

struct Weather: Decodable {
    let id: Int
    let main: String
    let description: String
}
