//
//  City.swift
//  WeatherApp
//
//  Created by Света Шибаева on 23.08.2022.
//

import Foundation

struct City: Decodable, Equatable {
    let name: String
    let localNames: [String: String]?
    let lat, lon: Double
    
    var localName: String {
        return localNames?["ru"] ?? name
    }
    
    init(from cityEntity: CityEntity) {
        name = cityEntity.name
        lat = cityEntity.lat
        lon = cityEntity.lon
        localNames = nil
    }
}
