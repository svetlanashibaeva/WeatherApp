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
    @NSManaged public var name: String
    @NSManaged public var lat: Double
    @NSManaged public var lon: Double
}
