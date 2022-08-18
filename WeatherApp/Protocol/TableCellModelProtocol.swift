//
//  CellModelProtocol.swift
//  WeatherApp
//
//  Created by Света Шибаева on 16.08.2022.
//

import UIKit

protocol TableCellModelProtocol {
    var cellIdentifier: String { get }
    func configureCell(_ cell: UITableViewCell)
}
