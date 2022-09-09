//
//  CityEntity+CoreDataClass.swift
//  WeatherApp
//
//  Created by Света Шибаева on 24.08.2022.
//
//

import Foundation
import CoreData

@objc(CityEntity)
public class CityEntity: NSManagedObject {
    
    static func saveCity(from city: City) {
        let cityEntity = CityEntity(context: CoreDataService.shared.context)
        
        cityEntity.name = city.name
        cityEntity.lat = city.lat
        cityEntity.lon = city.lon
    }
}
