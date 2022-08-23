//
//  DailyWeatherCellModel.swift
//  WeatherApp
//
//  Created by Света Шибаева on 16.08.2022.
//

import UIKit

struct DailyWeatherCellModel: TableCellModelProtocol {
    let cellIdentifier = "DailyWeatherCell"
    
    let day: String
    let minTemp: String
    let maxTemp: String
    
    func configureCell(_ cell: UITableViewCell) {
        guard let cell = cell as? DailyWeatherCell else { return }
        cell.dayLabel.text = day
        cell.minTempLabel.text = minTemp
        cell.maxTempLabel.text = maxTemp
    } 
}
