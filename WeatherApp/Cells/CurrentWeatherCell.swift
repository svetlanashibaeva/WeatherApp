//
//  CurrentWeatherCellTableViewCell.swift
//  WeatherApp
//
//  Created by Света Шибаева on 16.08.2022.
//

import UIKit

class CurrentWeatherCell: UITableViewCell {
    
    let cityNameLabel = UILabel()
    let curentTemperatureLabel = UILabel()
    let forecastLabel = UILabel()
    let feelsLikeLabel = UILabel()
    let weatherIcon = UIImageView()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configure()
        addSubviews()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension CurrentWeatherCell {
    
    func configure() {
        cityNameLabel.text = "Piter"
        cityNameLabel.font = UIFont.systemFont(ofSize: 22)
        cityNameLabel.textAlignment = .center
        
        curentTemperatureLabel.text = "23°"
        curentTemperatureLabel.font = UIFont.systemFont(ofSize: 70)
        curentTemperatureLabel.textAlignment = .center
        
        feelsLikeLabel.text = "Ощущается как: "
        feelsLikeLabel.font = UIFont.systemFont(ofSize: 17)
        feelsLikeLabel.textAlignment = .center
        
        forecastLabel.text = "Ясно"
        forecastLabel.font = UIFont.systemFont(ofSize: 17)
        forecastLabel.textAlignment = .center
    }
    
    func addSubviews() {
        [cityNameLabel, curentTemperatureLabel, feelsLikeLabel, forecastLabel, weatherIcon].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
    }
    
    func makeConstraints() {
        NSLayoutConstraint.activate([
            cityNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            cityNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            cityNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            
            curentTemperatureLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            curentTemperatureLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            curentTemperatureLabel.topAnchor.constraint(equalTo: cityNameLabel.bottomAnchor, constant: 8),
            
            feelsLikeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            feelsLikeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            feelsLikeLabel.topAnchor.constraint(equalTo: curentTemperatureLabel.bottomAnchor, constant: 8),
            
            weatherIcon.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            weatherIcon.widthAnchor.constraint(equalToConstant: 70),
            weatherIcon.heightAnchor.constraint(equalToConstant: 50),
            weatherIcon.topAnchor.constraint(equalTo: feelsLikeLabel.bottomAnchor, constant: 8),
            
            forecastLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            forecastLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            forecastLabel.topAnchor.constraint(equalTo: weatherIcon.bottomAnchor, constant: 8),
            forecastLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }
}
