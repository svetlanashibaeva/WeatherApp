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
    let currentTemp: String
    let feelsLike: String
    let forecast: String
    let weatherIcon: String
    
    func configureCell(_ cell: UITableViewCell) {
        guard let cell = cell as? CurrentWeatherCell else { return }
        cell.cityNameLabel.text = city
        cell.currentTemperatureLabel.text = currentTemp
        cell.forecastLabel.text = forecast
        cell.feelsLikeLabel.text = "Ощущается как " + feelsLike
        cell.weatherIcon.image = UIImage(systemName: weatherIcon)
    }
}
