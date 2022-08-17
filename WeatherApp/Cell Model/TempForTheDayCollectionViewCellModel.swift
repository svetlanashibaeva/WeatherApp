//
//  TemperatureForTheDayModel.swift
//  WeatherApp
//
//  Created by Света Шибаева on 17.08.2022.
//

import UIKit

struct TempForTheDayCollectionViewCellModel: CellModelProtocol {
    let cellIdentifier = "TemperaturePerDayCell"
    
    let timesArray: [TempForTheDayCollectionViewCell]
    
    func configureCell(_ cell: UITableViewCell) {
        guard let cell = cell as? TempForTheDayCollectionViewCell else { return }
        cell.timeLabel.text = time
    } 
}
