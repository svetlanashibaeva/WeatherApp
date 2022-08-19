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
        apiService.performRequest(with: WeatherEndpoint.getCurrentWeather, type: CurrentWeather.self, completion: completion)
    }
    
    func getForecast(completion: @escaping (Result<ForecastModel, Error>) -> ()) {
        apiService.performRequest(with: WeatherEndpoint.getForecast, type: ForecastModel.self, completion: completion)
    }
}


