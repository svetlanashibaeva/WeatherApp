//
//  CurrentWeatherView.swift
//  WeatherApp
//
//  Created by Света Шибаева on 09.09.2022.
//

import UIKit

class CurrentWeatherView: UIView {
    
    let tableView = UITableView()
    let disableLocationView = UIView()
    let openSettingsButton = UIButton()
    let messageLabel = UILabel()
    let activityIndicator = UIActivityIndicatorView()
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        
        configure()
        addSubviews()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension CurrentWeatherView {
    
    func configure() {
        
        backgroundColor = .defaultBackground
    
        disableLocationView.isHidden = true
        
        openSettingsButton.backgroundColor = .blue
        openSettingsButton.setTitle("Открыть настройки", for: .normal)
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.text = "Разрешите приложению получать Вашу текущую позицию"
        
        tableView.register(CurrentWeatherCell.self, forCellReuseIdentifier: "CurrentWeatherCell")
        tableView.register(TemperaturePerDayCell.self, forCellReuseIdentifier: "TemperaturePerDayCell")
        tableView.register(DailyWeatherCell.self, forCellReuseIdentifier: "DailyWeatherCell")
        tableView.backgroundColor = .defaultBackground
        
        activityIndicator.style = .large
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
    }
    
    func addSubviews() {
        [tableView, disableLocationView, activityIndicator].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
        
        [openSettingsButton, messageLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            disableLocationView.addSubview($0)
        }
    }
    
    func makeConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            
            openSettingsButton.centerXAnchor.constraint(equalTo: disableLocationView.centerXAnchor),
            openSettingsButton.centerYAnchor.constraint(equalTo: disableLocationView.centerYAnchor),
            openSettingsButton.widthAnchor.constraint(equalToConstant: 190),
            openSettingsButton.heightAnchor.constraint(equalToConstant: 40),
            
            messageLabel.trailingAnchor.constraint(equalTo: disableLocationView.trailingAnchor, constant: -16),
            messageLabel.leadingAnchor.constraint(equalTo: disableLocationView.leadingAnchor, constant: 16),
            messageLabel.bottomAnchor.constraint(equalTo: openSettingsButton.topAnchor, constant: -30),
            
            activityIndicator.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor)
        ])
        
        disableLocationView.constraintToSuperview()
    }
}
