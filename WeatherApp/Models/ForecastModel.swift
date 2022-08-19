//
//  ForecastModel.swift
//  WeatherApp
//
//  Created by Света Шибаева on 19.08.2022.
//

import Foundation

struct ForecastModel: Decodable {
    let list: [List]
    let city: City
}

struct List: Decodable {
    let main: MainWeather
    let dt: Date
}

struct City: Decodable {
    let id: Int
    let name: String
    let coord: Coordinate
}
