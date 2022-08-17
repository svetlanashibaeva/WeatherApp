//
//  DailyWeatherCellModel.swift
//  WeatherApp
//
//  Created by Света Шибаева on 16.08.2022.
//

import UIKit

struct DailyWeatherCellModel: CellModelProtocol {
    let cellIdentifier = "DailyWeatherCell"
    
    let day: String
    
    func configureCell(_ cell: UITableViewCell) {
        guard let cell = cell as? DailyWeatherCell else { return }
        cell.dayLabel.text = day
    }
    
    
}
