//
//  ModuleFactory+SearchModule.swift
//  WeatherApp
//
//  Created by Светлана Шибаева on 19.07.2024.
//

import Foundation

protocol SearchModuleFactory {
    func searchModule() -> SearchViewController
}

extension ModuleFactory: SearchModuleFactory {
    
    func searchModule() -> SearchViewController {
        return SearchViewController(
            dp: .init(
                coreDataService: DIManager.shared.resolve(type: CoreDataServiceProtocol.self),
                weatherService: DIManager.shared.resolve(type: WeatherServiceProtocol.self)
            )
        )
    }
}
