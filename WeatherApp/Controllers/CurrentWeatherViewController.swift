//
//  CurrentWeatherViewController.swift
//  WeatherApp
//
//  Created by Света Шибаева on 16.08.2022.
//

import UIKit

class CurrentWeatherViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let cellModels: [TableCellModelProtocol] = [
        CurrentWeatherCellModel(city: "Ekaterinburg"),
        DailyWeatherCellModel(day: "Понедельник"),
        DailyWeatherCellModel(day: "Вторник"),
        DailyWeatherCellModel(day: "Среда"),
        TemperaturePerDayCellModel(timesArray: [
            TempForTheDayCollectionViewCellModel(time: "Сейчас"),
            TempForTheDayCollectionViewCellModel(time: "14"),
            TempForTheDayCollectionViewCellModel(time: "16"),
            TempForTheDayCollectionViewCellModel(time: "18"),
            TempForTheDayCollectionViewCellModel(time: "20"),
            TempForTheDayCollectionViewCellModel(time: "22"),
            TempForTheDayCollectionViewCellModel(time: "24"),
            TempForTheDayCollectionViewCellModel(time: "26")
        ])
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}

extension CurrentWeatherViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellModel = cellModels[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: cellModel.cellIdentifier, for: indexPath)
        cellModel.configureCell(cell)
        return cell
    }
    
    
}

extension CurrentWeatherViewController: UITableViewDelegate {
    
}
