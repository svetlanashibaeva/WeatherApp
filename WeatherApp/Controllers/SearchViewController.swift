//
//  SearchViewController.swift
//  WeatherApp
//
//  Created by Света Шибаева on 23.08.2022.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    private var cellModels: [TableCellModelProtocol] = []
    private let weatherService = WeatherService()
    
    private let activityIndicator = UIActivityIndicatorView(style: .medium)
   
    private var isLoading = false
    private var timer: Timer?
    private var city: City?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
    private func clear() {
        cellModels = []
        tableView.reloadData()
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let currentVC = segue.destination as! CurrentWeatherViewController
        
        if let city = city {
            currentVC.city = city
        }
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
            clear()
            return
        }
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false, block: { [weak self] (timer) in
            self?.loadData(city: searchText)
        })
    }
}
