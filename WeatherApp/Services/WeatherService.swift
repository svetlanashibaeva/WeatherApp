//
//  WeatherService.swift
//  WeatherApp
//
//  Created by Света Шибаева on 18.08.2022.
//

import Foundation

class WeatherService {
    
    private let apiService = ApiService()

    func getWeather(lat: Double, lon: Double, completion: @escaping (Result<CurrentWeather, Error>) -> ()) {
        apiService.performRequest(with: WeatherEndpoint.getCurrentWeather(lat: lat, lon: lon), type: CurrentWeather.self, completion: completion)
    }
    
    func getForecast(lat: Double, lon: Double, completion: @escaping (Result<ForecastModel, Error>) -> ()) {
        apiService.performRequest(with: WeatherEndpoint.getForecast(lat: lat, lon: lon), type: ForecastModel.self, completion: completion)
    }
    
    func getCity(name: String, completion: @escaping (Result<[City], Error>) -> ()) {
        apiService.performRequest(with: WeatherEndpoint.getCity(name: name), type: [City].self, completion: completion)
    }
}


