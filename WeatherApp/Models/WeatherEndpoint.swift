//
//  WeatherEndpoint.swift
//  WeatherApp
//
//  Created by Света Шибаева on 18.08.2022.
//

import Foundation

enum WeatherEndpoint {
    case getCurrentWeather(lat: Double, lon: Double)
    case getForecast(lat: Double, lon: Double)
    case getCity(name: String)
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
        case .getCity:
            return "/geo/1.0/direct"
        }
    }
    
    var params: [String : String] {
        var params = ["appid": "e382f69da8950542f476171cc68678de", "lang": "ru", "units": "metric"]
        switch self {
        case let .getCurrentWeather(lat, lon),
             let .getForecast(lat, lon):
            params["lat"] = "\(lat)"
            params["lon"] = "\(lon)"
        case let .getCity(name):
            params["limit"] = "0"
            params["q"] = name
        }
        return params
    }
}

