//
//  CurrentWeatherCellModel.swift
//  WeatherApp
//
//  Created by Света Шибаева on 16.08.2022.
//

import UIKit

struct CurrentWeatherCellModel: TableCellModelProtocol {
    let cellIdentifier = "CurrentWeatherCell"
    
    let city: String
    
    func configureCell(_ cell: UITableViewCell) {
        guard let cell = cell as? CurrentWeatherCell else { return }
        cell.cityNameLabel.text = city
    }
}
