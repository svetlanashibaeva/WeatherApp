//
//  ApiError.swift
//  WeatherApp
//
//  Created by Света Шибаева on 18.08.2022.
//

import Foundation

struct ApiError: Decodable {
    let code: String
    let message: String
}
