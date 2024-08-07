//
//  SearchViewController.swift
//  WeatherApp
//
//  Created by Света Шибаева on 23.08.2022.
//

import UIKit
import CoreData

protocol SearchControllerDelegate: AnyObject {
    func showSelectedPage(at index: Int)
    func updateSavedCities()
}

extension SearchViewController {
    
    struct Dependencies {
        let coreDataService: CoreDataServiceProtocol
        let weatherService: WeatherServiceProtocol
    }
}

class SearchViewController: UIViewController, CurrentWeatherViewControllerDelegate {
    
    private let customView = SearchView()
    weak var delegate: SearchControllerDelegate?

    private var cellModels: [TableCellModelProtocol] = []
    private var savedCities = [CityEntity]()
    
    private var timer: Timer?
    
    private let dp: Dependencies
    
    init(dp: Dependencies) {
        self.dp = dp
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = customView
    }
     
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showSavedCities()
        
        customView.tableView.dataSource = self
        customView.tableView.delegate = self
        customView.searchBar.delegate = self
    }
    
    func loadData(city: String?) {
        guard let city = city, !city.isEmpty else { return }
        
        customView.activityIndicator.startAnimating()
        
        dp.weatherService.getCity(name: city) { [weak self] result in
            guard let self = self else { return }
            
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
                self.customView.activityIndicator.stopAnimating()
                self.customView.tableView.reloadData()
            }
        }
    }
    
    func update() {
        delegate?.updateSavedCities()
        showSavedCities()
        customView.searchBar.text = ""
    }
    
    private func showSavedCities() {
        cellModels = [SearchCellModel(city: nil)]
        
        savedCities = dp.coreDataService.getCities()
        cellModels += savedCities.map { cityEntity in
            SearchCellModel(city: City(from: cityEntity))
        }
        
        customView.tableView.reloadData()
    }
    
    func showCity(city: City?) {
        let currentVC = ModuleFactory.shared.currentWeatherModule()
        
        if let city = city {
            currentVC.city = city
            currentVC.isCitySaved = savedCities.contains(where: { $0.lat == city.lat && $0.lon == city.lon })
        }
        currentVC.delegate = self
        
        let navigationController = UINavigationController(rootViewController: currentVC)
        
        present(navigationController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        guard customView.searchBar.text == "" && indexPath.row != 0 else { return nil }
        let delete = deleteAction(at: indexPath)
        return UISwipeActionsConfiguration(actions: [delete])
    }
    
    func deleteAction(at indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .destructive, title: "Delete") { [weak self] action, view, completion in
            guard let self = self else { return }
            let savedCity = self.savedCities[indexPath.row - 1]
            dp.coreDataService.deleteCity(from: savedCity)
            self.savedCities.remove(at: indexPath.row - 1)
            dp.coreDataService.saveContext {
                self.cellModels.remove(at: indexPath.row)
                self.delegate?.updateSavedCities()
                self.customView.tableView.reloadData()
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
        
        if customView.searchBar.text == "" {
            delegate?.showSelectedPage(at: indexPath.row)
            dismiss(animated: true)
        } else {
            let city = (cellModels[indexPath.row] as? SearchCellModel)?.city
            showCity(city: city)
        }
    }
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        timer?.invalidate()
        
        guard let searchText = searchBar.text, !searchText.isEmpty else {
            showSavedCities()
            return
        }
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false, block: { [weak self] timer in
            self?.loadData(city: searchText)
        })
    }
}

