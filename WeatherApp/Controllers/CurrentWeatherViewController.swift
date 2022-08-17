//
//  CurrentWeatherViewController.swift
//  WeatherApp
//
//  Created by Света Шибаева on 16.08.2022.
//

import UIKit

class CurrentWeatherViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let array = ["Понедельник", "Вторник", "Среда"]
    
    let cellModels: [CellModelProtocol] = [
        CurrentWeatherCellModel(city: "Ekaterinburg"),
        DailyWeatherCellModel(day: "Понедельник"),
        DailyWeatherCellModel(day: "Вторник"),
        DailyWeatherCellModel(day: "Среда"),
        TempForTheDayCollectionViewCellModel(time: "Сейчас"),
        TempForTheDayCollectionViewCellModel(time: "14"),
        TempForTheDayCollectionViewCellModel(time: "16"),
        TempForTheDayCollectionViewCellModel(time: "18"),
        TempForTheDayCollectionViewCellModel(time: "20"),
        TempForTheDayCollectionViewCellModel(time: "22")
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
//        if indexPath.row == 0 {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "CurrentWeatherCell", for: indexPath) as! CurrentWeatherCell
//            cell.config(city: "Екатеринбург")
//            return cell
//        } else {
//            let dailyCell = tableView.dequeueReusableCell(withIdentifier: "DailyWeatherCell", for: indexPath) as! DailyWeatherCell
//            dailyCell.configure(day: array[indexPath.row - 1])
//            return dailyCell
//        }
        let cellModel = cellModels[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: cellModel.cellIdentifier, for: indexPath)
        cellModel.configureCell(cell)
        return cell
    }
    
    
}

extension CurrentWeatherViewController: UITableViewDelegate {
    
}
