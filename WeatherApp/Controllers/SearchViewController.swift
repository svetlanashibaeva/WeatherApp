//
//  SearchViewController.swift
//  WeatherApp
//
//  Created by Света Шибаева on 23.08.2022.
//

import UIKit
import CoreData

class SearchViewController: UIViewController, CurrentWeatherViewControllerDelegate {
   
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    weak var delegate: CurrentWeatherViewControllerDelegate?
    
    private var cellModels: [TableCellModelProtocol] = []
    private let weatherService = WeatherService()
    
    private let activityIndicator = UIActivityIndicatorView(style: .medium)
   
    private var isLoading = false
    private var timer: Timer?
    private var city: City?
    private var savedCities = [CityEntity]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showSavedCities()
        
        searchBar.delegate = self
    }
    
    func loadData(city: String?) {
        guard let city = city, !city.isEmpty else { return }
        isLoading = true
        
        weatherService.getCity(name: city) { result in
            switch result {
            case let .success(response):
                self.cellModels = response.map { city in
                    SearchCellModel(city: city)
                }
            case let .failure(error):
                DispatchQueue.main.async {
                    self.showError(error: error.localizedDescription)
                }
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.isLoading = false
            }
        }
    }
    
    func update() {
        showSavedCities()
        searchBar.text = ""
    }
    
    private func showSavedCities() {
        do {
            savedCities = try CoreDataService.shared.context.fetch(CityEntity.fetchRequest())
            cellModels = savedCities.map { cityEntity in
                SearchCellModel(city: City(from: cityEntity))
            }
        } catch {
            savedCities = []
            cellModels = []
        }
        
        tableView.reloadData()
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let currentVC = segue.destination as! CurrentWeatherViewController
        
        if let city = city {
            currentVC.city = city
            currentVC.isCitySaved = savedCities.contains(where: { $0.lat == city.lat && $0.lon == city.lon })
        }
        
        currentVC.delegate = self
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = deleteAction(at: indexPath)
        return UISwipeActionsConfiguration(actions: [delete])
    }
    
    func deleteAction(at indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completion) in
            let savedCity = self.savedCities[indexPath.row]
            CoreDataService.shared.context.delete(savedCity)
            self.savedCities.remove(at: indexPath.row)
            CoreDataService.shared.saveContext {
                self.cellModels.remove(at: indexPath.row)
                self.tableView.reloadData()
            }
        }
        return action
    }

}

extension SearchViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cellModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellModel = cellModels[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: cellModel.cellIdentifier, for: indexPath)
        cellModel.configureCell(cell)
        return cell
    }

}

extension SearchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        city = (cellModels[indexPath.row] as? SearchCellModel)?.city
        
        performSegue(withIdentifier: "ShowCurrentWeather", sender: self)
    }
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        timer?.invalidate()
        
        guard let searchText = searchBar.text, !searchText.isEmpty else {
            showSavedCities()
            return
        }
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false, block: { [weak self] (timer) in
            self?.loadData(city: searchText)
        })
    }
}

