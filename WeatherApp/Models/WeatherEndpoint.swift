//
//  WeatherEndpoint.swift
//  WeatherApp
//
//  Created by Света Шибаева on 18.08.2022.
//

import Foundation

enum WeatherEndpoint {
    case getWeather
}

extension WeatherEndpoint: EndpointProtocol {
    
    var host: String {
        return "api.openweathermap.org"
    }
    
    var path: String {
        switch self {
        case .getWeather:
            return "/data/3.0/onecall"
        }
    }
    
    var params: [String : String] {
        var params = ["appid": "e382f69da8950542f476171cc68678de", "lang": "ru", "units": "metric"]
        switch self {
        case .getWeather:
            params["q"] = "Moscow"
        }
        return params
    }
}

