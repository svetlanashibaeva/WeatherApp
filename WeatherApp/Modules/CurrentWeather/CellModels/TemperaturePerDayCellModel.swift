//
//  TemperatureForTheDayModel.swift
//  WeatherApp
//
//  Created by Света Шибаева on 17.08.2022.
//

import UIKit

struct TemperaturePerDayCellModel: TableCellModelProtocol {
    let cellIdentifier = "TemperaturePerDayCell"
    
    let timesArray: [TempForTheDayCollectionViewCellModel]
    
    func configureCell(_ cell: UITableViewCell) {
        guard let cell = cell as? TemperaturePerDayCell else { return }
        cell.cellModels = timesArray
    } 
}
