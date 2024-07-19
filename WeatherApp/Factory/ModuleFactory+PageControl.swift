//
//  ModuleFactory+PageControl.swift
//  WeatherApp
//
//  Created by Светлана Шибаева on 19.07.2024.
//

import Foundation

protocol PageControlModuleFactory {
    func pageControlModule() -> PageControlViewController
}

extension ModuleFactory: PageControlModuleFactory {
    
    func pageControlModule() -> PageControlViewController {
        return PageControlViewController(
            dp: .init(
                coreDataService: DIManager.shared.resolve(type: CoreDataServiceProtocol.self)
            )
        )
    }
}
