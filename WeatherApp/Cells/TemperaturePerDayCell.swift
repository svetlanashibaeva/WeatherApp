//
//  TemperaturePerDayCell.swift
//  WeatherApp
//
//  Created by Света Шибаева on 17.08.2022.
//

import UIKit

class TemperaturePerDayCell: UITableViewCell {
    
    lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = CGSize(width: 80, height: 120)
        
        return UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
    }()
    
    var cellModels = [CollectionCellModelProtocol]()
    
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

private extension TemperaturePerDayCell {
    
    func configure() {
        backgroundColor = .defaultBackground
        collectionView.dataSource = self
        collectionView.register(TempForTheDayCollectionViewCell.self, forCellWithReuseIdentifier: "TempForTheCollectionViewCellModel")
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .defaultBackground
    }
    
    func addSubviews() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(collectionView)
    }
    
    func makeConstraints() {
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            collectionView.heightAnchor.constraint(equalToConstant: 120)
        ])
    }
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

