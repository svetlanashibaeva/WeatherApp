//
//  CurrentWeatherViewController.swift
//  WeatherApp
//
//  Created by Света Шибаева on 16.08.2022.
//

import UIKit

class CurrentWeatherViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var city: City?
    
    private let weatherService = WeatherService()
    private var cellModels: [TableCellModelProtocol] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let city = city else { return }
        loadData(city: city)
    }
    
    private func loadData(city: City) {
        var currentWeather: CurrentWeather?
        var forecast: ForecastModel?
        var responseError: String?
        
        let taskLoadData = DispatchGroup()
        taskLoadData.enter()
        weatherService.getWeather(lat: city.lat, lon: city.lon) { result in
            switch result {
            case let .success(response):
                currentWeather = response
                
            case let .failure(error):
                responseError = error.localizedDescription
            }
            
            taskLoadData.leave()
        }
        
        taskLoadData.enter()
        weatherService.getForecast(lat: city.lat, lon: city.lon) { result in
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
                self.cellModels = self.buildCellModels(
                    currentWeather: currentWeather,
                    forecast: forecast,
                    name: city.localName
                )
                self.tableView.reloadData()
            }
        }
    }

    func buildCellModels(
        currentWeather: CurrentWeather,
        forecast: ForecastModel,
        name: String
    ) -> [TableCellModelProtocol] {

        let hourly = forecast.list
            .prefix(8)
            .map { interval in
            TempForTheDayCollectionViewCellModel(time: interval.dt.hour, temperature: interval.main.temp.toTempString)
        }

        let daily = getDailyCellModels(list: forecast.list)

        let models: [TableCellModelProtocol] = [
            CurrentWeatherCellModel(
                city: name,
                currentTemp: currentWeather.main.temp.toTempString,
                feelsLike: currentWeather.main.feelsLike.toTempString,
                forecast: currentWeather.weather.first?.description.capitalized ?? ""
            ),
            TemperaturePerDayCellModel(timesArray: hourly)
        ]

        return models + daily
    }
    
    func getDailyCellModels(list: [List]) -> [TableCellModelProtocol] {
        guard let firstInterval = list.first else { return [] }
        
        var daily = [TableCellModelProtocol]()
        var date = firstInterval.dt.weekday
        
        var max = firstInterval.main.tempMax
        var min = firstInterval.main.tempMin
        
        for index in 1...list.count - 1 {
            let interval = list[index]
            
            let isDateEqual = date == interval.dt.weekday
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
                    day: daily.isEmpty ? "Сегодня" : date.capitalized,
                    minTemp: min.toTempString,
                    maxTemp: max.toTempString
                ))
                date = interval.dt.weekday
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
