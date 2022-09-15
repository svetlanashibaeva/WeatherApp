//
//  CurrentWeatherViewController.swift
//  WeatherApp
//
//  Created by Света Шибаева on 16.08.2022.
//

import UIKit
import CoreData
import CoreLocation

class CurrentWeatherViewController: UIViewController {

    private let customView = CurrentWeatherView()
    
    var city: City?
    var isCitySaved = false
    weak var delegate: CurrentWeatherViewControllerDelegate?
    
    private let locationManager = CLLocationManager()
    private let weatherService = WeatherService()
    private var cellModels: [TableCellModelProtocol] = []
    
    override func loadView() {
        view = customView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customView.tableView.dataSource = self
        customView.openSettingsButton.addTarget(self, action: #selector(openSettings), for: .touchUpInside)
        
        if let city = city {
            navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Отмена", style: .done, target: self, action: #selector(closeCurrentVC))
            if !isCitySaved {
                navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Добавить", style: .done, target: self, action: #selector(addToCoreData))
            }
            
            loadData(lat: city.lat, lon: city.lon, name: city.localName)
        } else {
            if (CLLocationManager.locationServicesEnabled()) {
                locationManager.delegate = self
                locationManager.distanceFilter = 100
                locationManager.requestWhenInUseAuthorization()
                locationManager.startUpdatingLocation()
            }
        }
    }
    
    @objc func addToCoreData() {
        guard let city = city else { return }
        
        CityEntity.saveCity(from: city)
        CoreDataService.shared.saveContext {
            self.delegate?.update()
            self.dismiss(animated: true)
        }
    }
    
    @objc func closeCurrentVC() {
        dismiss(animated: true)
    }
    
    @objc func openSettings() {
        if let url = URL(string: UIApplication.openSettingsURLString), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
    
    private func loadData(lat: Double, lon: Double, name: String) {
        var currentWeather: CurrentWeather?
        var forecast: ForecastModel?
        var responseError: String?
        
        customView.activityIndicator.startAnimating()
        
        let taskLoadData = DispatchGroup()
        taskLoadData.enter()
        weatherService.getWeather(lat: lat, lon: lon) { result in
            switch result {
            case let .success(response):
                currentWeather = response
                
            case let .failure(error):
                responseError = error.localizedDescription
            }
            
            taskLoadData.leave()
        }
        
        taskLoadData.enter()
        weatherService.getForecast(lat: lat, lon: lon) { result in
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
                    name: name
                )
                self.customView.activityIndicator.stopAnimating()
                self.customView.tableView.reloadData()
            }
        }
    }
    
    func setCityName(from location: CLLocation) {
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { [weak self] placemarks, error in
            guard let placemark = placemarks?.first,
                  let cityName = placemark.locality
            else { return }
            
            self?.loadData(lat: location.coordinate.latitude, lon: location.coordinate.longitude, name: cityName)
        }
    }

    func buildCellModels(currentWeather: CurrentWeather, forecast: ForecastModel, name: String) -> [TableCellModelProtocol] {

        let hourly = forecast.list
            .prefix(8)
            .map { interval in
                TempForTheDayCollectionViewCellModel(
                    time: interval.dt.hour,
                    temperature: interval.main.temp.toTempString,
                    weatherIcon: interval.weather.first?.main.imageName ?? ""
                )
        }

        let daily = getDailyCellModels(list: forecast.list)

        let models: [TableCellModelProtocol] = [
            CurrentWeatherCellModel(
                city: name,
                currentTemp: currentWeather.main.temp.toTempString,
                feelsLike: currentWeather.main.feelsLike.toTempString,
                forecast: currentWeather.weather.first?.description.capitalizingFirstLetter ?? "",
                weatherIcon: currentWeather.weather.first?.main.imageName ?? ""
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
        cell.selectionStyle = .none
        return cell
    }
}

extension CurrentWeatherViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = manager.location else { return }
        setCityName(from: location)
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        customView.disableLocationView.isHidden = !(manager.authorizationStatus == .denied || manager.authorizationStatus == .restricted)
    }
}
