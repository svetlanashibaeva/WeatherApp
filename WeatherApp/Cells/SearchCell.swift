//
//  SearchCell.swift
//  WeatherApp
//
//  Created by Света Шибаева on 23.08.2022.
//

import UIKit

class SearchCell: UITableViewCell {
    
    let cityNameLabel = UILabel()
    
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

private extension SearchCell {
    
    func configure() {
        cityNameLabel.font = UIFont.systemFont(ofSize: 17, weight: .light)
    }
    
    func addSubviews() {
        cityNameLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(cityNameLabel)
    }
    
    func makeConstraints() {
        NSLayoutConstraint.activate([
            cityNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            cityNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            cityNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            cityNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }
}
