//
//  CoreDataService.swift
//  WeatherApp
//
//  Created by Светлана Шибаева on 19.07.2024.
//

import Foundation
import CoreData

protocol CoreDataServiceProtocol {
    func saveCity(from city: City)
    func getCities() -> [CityEntity]
    func saveContext(completion: (() -> ())?)
    func deleteCity(from city: CityEntity)
}

final class CoreDataService: CoreDataServiceProtocol {
    
    private let cdManager = CoreDataManager.shared
    
    func getCities() -> [CityEntity] {
        cdManager.getEntities(type: CityEntity.self)
    }
  
    func saveCity(from city: City) {
        let cityEntity = CityEntity(context: cdManager.context)
        
        cityEntity.name = city.name
        cityEntity.lat = city.lat
        cityEntity.lon = city.lon
    }
    
    func deleteCity(from city: CityEntity) {
        cdManager.context.delete(city)
    }
    
    func saveContext(completion: (() -> ())? = nil) {
        cdManager.saveContext(completion: completion)
    }
}
