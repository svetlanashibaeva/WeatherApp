//
//  ModuleFactory+Weather.swift
//  WeatherApp
//
//  Created by Светлана Шибаева on 18.07.2024.
//

import Foundation

protocol WeatherModuleFactory {
    func currentWeatherModule() -> CurrentWeatherViewController
}

extension ModuleFactory: WeatherModuleFactory {
    
    func currentWeatherModule() -> CurrentWeatherViewController {
        return CurrentWeatherViewController(
            dp: .init(
                weatherService: DIManager.shared.resolve(type: WeatherServiceProtocol.self),
                locationService: DIManager.shared.resolve(type: LocationServiceProtocol.self),
                coreDataService: DIManager.shared.resolve(type: CoreDataServiceProtocol.self)
            )
        )
    }
}
