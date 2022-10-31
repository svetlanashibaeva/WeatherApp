//
//  CurrentWeatherCellTableViewCell.swift
//  WeatherApp
//
//  Created by Света Шибаева on 16.08.2022.
//

import UIKit

class CurrentWeatherCell: UITableViewCell {
    
    let cityNameLabel = UILabel()
    let currentTemperatureLabel = UILabel()
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
        backgroundColor = .defaultBackground
        
        cityNameLabel.font = UIFont.systemFont(ofSize: 22, weight: .light)
        cityNameLabel.textAlignment = .center
        cityNameLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        
        currentTemperatureLabel.font = UIFont.systemFont(ofSize: 70)
        currentTemperatureLabel.textAlignment = .center
        currentTemperatureLabel.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        
        feelsLikeLabel.font = UIFont.systemFont(ofSize: 17, weight: .light)
        feelsLikeLabel.textAlignment = .center
        feelsLikeLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        
        forecastLabel.font = UIFont.systemFont(ofSize: 17, weight: .light)
        forecastLabel.textAlignment = .center
        forecastLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        
        weatherIcon.contentMode = .scaleAspectFit
    }
    
    func addSubviews() {
        [cityNameLabel, currentTemperatureLabel, feelsLikeLabel, forecastLabel, weatherIcon].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
    }
    
    func makeConstraints() {
        NSLayoutConstraint.activate([
            cityNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            cityNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            cityNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            
            currentTemperatureLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            currentTemperatureLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            currentTemperatureLabel.topAnchor.constraint(equalTo: cityNameLabel.bottomAnchor, constant: 8),
            
            feelsLikeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            feelsLikeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            feelsLikeLabel.topAnchor.constraint(equalTo: currentTemperatureLabel.bottomAnchor, constant: 8),
            
            weatherIcon.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            weatherIcon.widthAnchor.constraint(equalToConstant: 60),
            weatherIcon.heightAnchor.constraint(equalToConstant: 60),
            weatherIcon.topAnchor.constraint(equalTo: feelsLikeLabel.bottomAnchor, constant: 8),
            
            forecastLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            forecastLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            forecastLabel.topAnchor.constraint(equalTo: weatherIcon.bottomAnchor, constant: 8),
            forecastLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }
}
