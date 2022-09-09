//
//  ForecastModel.swift
//  WeatherApp
//
//  Created by Света Шибаева on 19.08.2022.
//

import Foundation

struct ForecastModel: Decodable {
    let list: [List]
}

struct List: Decodable {
    let main: MainWeather
    let dt: Date
    let weather: [WeatherDescription]
}
