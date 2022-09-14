//
//  DailyWeatherCell.swift
//  WeatherApp
//
//  Created by Света Шибаева on 16.08.2022.
//

import UIKit

class DailyWeatherCell: UITableViewCell {
    
    let dayLabel = UILabel()
    let minTempLabel = UILabel()
    let maxTempLabel = UILabel()
    
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

private extension DailyWeatherCell {
    
    func configure() {
        dayLabel.text = "Сегодня"
        dayLabel.font = UIFont.systemFont(ofSize: 17)
        
        minTempLabel.font = UIFont.systemFont(ofSize: 17)
        minTempLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        minTempLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        
        maxTempLabel.font = UIFont.systemFont(ofSize: 17)
        maxTempLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        maxTempLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
    }
    
    func addSubviews() {
        [dayLabel, minTempLabel, maxTempLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
    }
    
    func makeConstraints() {
        NSLayoutConstraint.activate([
            dayLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            dayLabel.trailingAnchor.constraint(equalTo: minTempLabel.leadingAnchor, constant: -16),
            dayLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            dayLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            
            minTempLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            minTempLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            
            maxTempLabel.leadingAnchor.constraint(equalTo: minTempLabel.trailingAnchor, constant: 32),
            maxTempLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            maxTempLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            maxTempLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
    }
}
