//
//  SearchCellModel.swift
//  WeatherApp
//
//  Created by Света Шибаева on 23.08.2022.
//

import UIKit

struct SearchCellModel: TableCellModelProtocol {
    let cellIdentifier = "SearchCell"
    
    let city: City
    
    func configureCell(_ cell: UITableViewCell) {
        guard let cell = cell as? SearchCell else { return }
        
        cell.cityNameLabel.text = city.name
    }
}
