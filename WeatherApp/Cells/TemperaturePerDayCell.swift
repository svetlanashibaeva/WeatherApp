//
//  TemperaturePerDayCell.swift
//  WeatherApp
//
//  Created by Света Шибаева on 17.08.2022.
//

import UIKit

class TemperaturePerDayCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var cellModels = [CollectionCellModelProtocol]()
}

extension TemperaturePerDayCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cellModel = cellModels[indexPath.item]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellModel.cellIdentifier, for: indexPath)
        cellModel.configureCell(cell)
        
        return cell
    }
}

extension TemperaturePerDayCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: collectionView.frame.height)
    }
}
