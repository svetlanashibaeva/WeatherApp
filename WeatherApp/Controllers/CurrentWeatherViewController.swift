//
//  CurrentWeatherViewController.swift
//  WeatherApp
//
//  Created by Света Шибаева on 16.08.2022.
//

import UIKit

class CurrentWeatherViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private let weatherService = WeatherService()
    private var currentWeather = [CurrentWeather]()
    
    var cellModels: [TableCellModelProtocol] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadData()
    }
    
    private func loadData() {
            
        weatherService.getWeather { [weak self] result in
                guard let self = self else { return }
                
                switch result {
                case let .success(response):
                    self.cellModels = self.buildCellModels(currentWeather: response)
   
                case let .failure(error):
                    DispatchQueue.main.async {
                        self.showError(error: error.localizedDescription)
                    }
                }
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }

    func buildCellModels(currentWeather: CurrentWeather) -> [TableCellModelProtocol] {
        
        return [
            CurrentWeatherCellModel(city: currentWeather.name, currentTemp: currentWeather.main.temp, feelsLike: currentWeather.main.feelsLike ?? 0)
        ]
        
//        CurrentWeatherCellModel(city: "Ekaterinburg"),
//        DailyWeatherCellModel(day: "Понедельник"),
//        DailyWeatherCellModel(day: "Вторник"),
//        DailyWeatherCellModel(day: "Среда"),
//        TemperaturePerDayCellModel(timesArray: [
//            TempForTheDayCollectionViewCellModel(time: "Сейчас"),
//            TempForTheDayCollectionViewCellModel(time: "14"),
//            TempForTheDayCollectionViewCellModel(time: "16"),
//            TempForTheDayCollectionViewCellModel(time: "18"),
//            TempForTheDayCollectionViewCellModel(time: "20"),
//            TempForTheDayCollectionViewCellModel(time: "22"),
//            TempForTheDayCollectionViewCellModel(time: "24"),
//            TempForTheDayCollectionViewCellModel(time: "26")
//        ])
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
