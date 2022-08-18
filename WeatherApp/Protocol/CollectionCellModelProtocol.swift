//
//  CollectionCellModelProtocol.swift
//  WeatherApp
//
//  Created by Света Шибаева on 18.08.2022.
//

import UIKit

protocol CollectionCellModelProtocol {
    var cellIdentifier: String { get }
    func configureCell(_ cell: UICollectionViewCell)
}
