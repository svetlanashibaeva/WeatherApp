//
//  DIConfigurator.swift
//  WeatherApp
//
//  Created by Светлана Шибаева on 18.07.2024.
//

import Foundation


final class DIConfigurator {
    
    static func registerDependencies() {
        DIManager.shared.register(type: WeatherServiceProtocol.self) {
            WeatherService(apiService: ApiManager())
        }
        
        DIManager.shared.register(type: CoreDataServiceProtocol.self) {
            CoreDataService()
        }
        
        DIManager.shared.register(type: LocationServiceProtocol.self) {
            LocationService()
        }
    }
}
