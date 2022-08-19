//
//  WeatherService.swift
//  WeatherApp
//
//  Created by Света Шибаева on 18.08.2022.
//

import Foundation

class WeatherService {
    
    private let apiService = ApiService()

    func getWeather(completion: @escaping (Result<CurrentWeather, Error>) -> ()) {
        apiService.performRequest(with: WeatherEndpoint.getWeather, type: CurrentWeather.self, completion: completion)
    }
}


