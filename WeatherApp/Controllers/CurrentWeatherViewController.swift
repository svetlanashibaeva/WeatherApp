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
    
    private var cellModels: [TableCellModelProtocol] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadData()
    }
    
    private func loadData() {
        var currentWeather: CurrentWeather?
        var forecast: ForecastModel?
        var responseError: String?
        
        let taskLoadData = DispatchGroup()
    
        
//        weatherService.getWeather { [weak self] result in
//            guard let self = self else { return }
//
//            switch result {
//            case let .success(response):
//                self.cellModels = self.buildCellModels(currentWeather: response)
//
//            case let .failure(error):
//                DispatchQueue.main.async {
//                    self.showError(error: error.localizedDescription)
//                }
//            }
//
//            DispatchQueue.main.async {
//                self.tableView.reloadData()
//            }
//        }
        
        taskLoadData.enter()
        weatherService.getWeather { result in
            switch result {
            case let .success(response):
                currentWeather = response
                
            case let .failure(error):
                responseError = error.localizedDescription
            }
            
            taskLoadData.leave()
        }
        
        taskLoadData.enter()
        weatherService.getForecast { result in
            switch result {
            case let .success(response):
                forecast = response
            case let .failure(error):
                responseError = error.localizedDescription
            }
            
            taskLoadData.leave()
        }
        
        taskLoadData.notify(queue: DispatchQueue.main) { [weak self] in
            guard let self = self else { return }
            
            if let responseError = responseError {
                self.showError(error: responseError)
            } else if let currentWeather = currentWeather, let forecast = forecast {
                self.cellModels = self.buildCellModels(currentWeather: currentWeather, forecast: forecast)
                self.tableView.reloadData()
            }
        }
    }

    func buildCellModels(currentWeather: CurrentWeather, forecast: ForecastModel) -> [TableCellModelProtocol] {

        let hourly = forecast.list
            .prefix(8)
            .map { interval in
            TempForTheDayCollectionViewCellModel(time: interval.dt.hour, temperature: interval.main.temp.toString)
        }

        let daily = getDailyCellModels(list: forecast.list)

        let models: [TableCellModelProtocol] = [
            CurrentWeatherCellModel(
                city: currentWeather.name,
                currentTemp: currentWeather.main.temp.toString,
                feelsLike: currentWeather.main.feelsLike.toString,
                forecast: currentWeather.weather.first?.description.capitalized ?? ""
            ),
            TemperaturePerDayCellModel(timesArray: hourly)
        ]

        return models + daily
    }
    
    func getDailyCellModels(list: [List]) -> [TableCellModelProtocol] {
        guard let firstInterval = list.first else { return [] }
        
        var daily = [TableCellModelProtocol]()
        var date = firstInterval.dt.day
        
        var max = firstInterval.main.tempMax
        var min = firstInterval.main.tempMin
        
        for index in 1...list.count - 1 {
            let interval = list[index]
            let isDateEqual = date == interval.dt.day
            let isListEnded = index == list.count - 1
            
            if isDateEqual || isListEnded {
                if interval.main.tempMax > max {
                    max = interval.main.tempMax
                }
                
                if interval.main.tempMin < min {
                    min = interval.main.tempMin
                }
            }
            
            if !isDateEqual || isListEnded {
                daily.append(DailyWeatherCellModel(
                    day: date,
                    minTemp: min.toString,
                    maxTemp: max.toString
                ))
                date = interval.dt.day
                min = interval.main.tempMin
                max = interval.main.tempMax
            }
        }
        
        return daily
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
