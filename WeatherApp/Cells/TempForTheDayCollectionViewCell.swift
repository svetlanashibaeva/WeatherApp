//
//  TempForTheDayCollectionViewCell.swift
//  WeatherApp
//
//  Created by Света Шибаева on 17.08.2022.
//

import UIKit

class TempForTheDayCollectionViewCell: UICollectionViewCell {
    
    let timeLabel = UILabel()
    let tempLabel = UILabel()
    let weatherIcon = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
        addSubviews()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension TempForTheDayCollectionViewCell {
    
    func configure() {
        backgroundColor = .defaultBackground
        
        timeLabel.textAlignment = .center
        timeLabel.font = UIFont.systemFont(ofSize: 17, weight: .light)
        timeLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        
        weatherIcon.setContentHuggingPriority(.defaultHigh, for: .vertical)
        weatherIcon.contentMode = .scaleAspectFit
        
        tempLabel.textAlignment = .center
        tempLabel.font = UIFont.systemFont(ofSize: 24, weight: .light)
        tempLabel.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
    }
    
    func addSubviews() {
        [timeLabel, tempLabel, weatherIcon].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
    }
    
    func makeConstraints() {
        NSLayoutConstraint.activate([
            timeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            timeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            timeLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            
            weatherIcon.widthAnchor.constraint(equalToConstant: 30),
            weatherIcon.heightAnchor.constraint(equalToConstant: 30),
            weatherIcon.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 8),
            weatherIcon.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            tempLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            tempLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            tempLabel.topAnchor.constraint(equalTo: weatherIcon.bottomAnchor, constant: 8),
            tempLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
}
