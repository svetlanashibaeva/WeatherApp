//
//  WeatherEndpoint.swift
//  WeatherApp
//
//  Created by Света Шибаева on 18.08.2022.
//

import Foundation

enum WeatherEndpoint {
    case getCurrentWeather
    case getForecast
}

extension WeatherEndpoint: EndpointProtocol {
    
    var host: String {
        return "api.openweathermap.org"
    }
    
    var path: String {
        switch self {
        case .getCurrentWeather:
            return "/data/2.5/weather"
        case .getForecast:
            return "/data/2.5/forecast"
        }
    }
    
    var params: [String : String] {
        var params = ["appid": "e382f69da8950542f476171cc68678de", "lang": "ru", "units": "metric"]
        switch self {
        case .getCurrentWeather:
            params["q"] = "Moscow"
        case .getForecast:
            params["q"] = "Moscow"
        }
        return params
    }
}

