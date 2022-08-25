//
//  CityEntity+CoreDataProperties.swift
//  WeatherApp
//
//  Created by Света Шибаева on 24.08.2022.
//
//

import Foundation
import CoreData


extension CityEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CityEntity> {
        return NSFetchRequest<CityEntity>(entityName: "CityEntity")
    }

    @NSManaged public var name: String
    @NSManaged public var lat: Double
    @NSManaged public var lon: Double

}

