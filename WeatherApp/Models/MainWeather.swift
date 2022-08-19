//
//  MainWeather.swift
//  WeatherApp
//
//  Created by Света Шибаева on 19.08.2022.
//

import Foundation

struct MainWeather: Decodable {
    let temp: Double
    let feelsLike: Double
    let tempMin: Double
    let tempMax: Double
}
