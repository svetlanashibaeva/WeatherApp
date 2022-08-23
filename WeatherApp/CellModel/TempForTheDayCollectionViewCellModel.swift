//
//  TempForTheCollectionViewCellModel.swift
//  WeatherApp
//
//  Created by Света Шибаева on 18.08.2022.
//

import UIKit

struct TempForTheDayCollectionViewCellModel: CollectionCellModelProtocol {
    let cellIdentifier = "TempForTheCollectionViewCellModel"
    
    let time: String
    let temperature: String
    
    func configureCell(_ cell: UICollectionViewCell) {
        guard let cell = cell as? TempForTheDayCollectionViewCell else { return }
        cell.timeLabel.text = time
        cell.tempLabel.text = temperature
    }
}
