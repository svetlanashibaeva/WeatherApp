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

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var cancelItem: UIBarButtonItem!
    @IBOutlet weak var addToCoreDataItem: UIBarButtonItem!
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    var city: City?
    var isCitySaved = false
    private let locationManager = CLLocationManager()
    weak var delegate: CurrentWeatherViewControllerDelegate?
    
    private let weatherService = WeatherService()
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    private var cellModels: [TableCellModelProtocol] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showActivityIndicator()
        
        if let city = city {
            
            if !isBeingPresented {
                navigationBar.isHidden = true
            } else if isCitySaved {
                addToCoreDataItem.isEnabled = false
                addToCoreDataItem.title = ""
            }
            
            loadData(lat: city.lat, lon: city.lon, name: city.localName)
        } else {
            navigationBar.isHidden = true
            if (CLLocationManager.locationServicesEnabled()) {
                locationManager.delegate = self
                locationManager.desiredAccuracy = kCLLocationAccuracyBest
                locationManager.requestWhenInUseAuthorization()
                locationManager.startUpdatingLocation()
            }
        }
    }
    
    @IBAction func addToCoreData(_ sender: Any) {
        guard let city = city else { return }
        
        CityEntity.saveCity(from: city)
        CoreDataService.shared.saveContext {
            self.delegate?.update()
            self.dismiss(animated: true)
        }
    }
    
    @IBAction func closeCurrentVC(_ sender: Any) {
        dismiss(animated: true)
    }
    
    private func showActivityIndicator() {
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        activityIndicator.center = view.center
        view.addSubview(activityIndicator)
    }
    
    private func loadData(lat: Double, lon: Double, name: String) {
        var currentWeather: CurrentWeather?
        var forecast: ForecastModel?
        var responseError: String?
        
        activityIndicator.startAnimating()
        
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
                self.activityIndicator.stopAnimating()
                self.tableView.reloadData()
            }
        }
    }
    
    func setCityName(from location: CLLocation) {
        
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { [weak self] (placemarks, error) in
            guard let placemark = placemarks?.first,
                  let cityName = placemark.locality
            else {  return }
            
            self?.loadData(lat: location.coordinate.latitude, lon: location.coordinate.longitude, name: cityName)
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
        return cell
    }
}

extension CurrentWeatherViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = manager.location else { return }
        setCityName(from: location)
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
    }
}
