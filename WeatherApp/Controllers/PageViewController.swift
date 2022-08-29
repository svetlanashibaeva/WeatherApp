//
//  PageViewController.swift
//  WeatherApp
//
//  Created by Света Шибаева on 29.08.2022.
//

import UIKit

class PageViewController: UIPageViewController {
    
    private var savedCities = [City]()
    private var currentPage = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        
        do {
            let cities = try CoreDataService.shared.context.fetch(CityEntity.fetchRequest())
            savedCities = cities.map { City(from: $0) }
        } catch let error as NSError{
            print(error.localizedDescription)
        }
    
        if let currentWeatherVC = showCurrentViewControllerAtIndex(currentPage) {
            setViewControllers([currentWeatherVC], direction: .forward, animated: true, completion: nil)
        }
    }

    func showCurrentViewControllerAtIndex(_ index: Int) -> CurrentWeatherViewController? {
        guard index >= 0 else { return nil }
        guard index < savedCities.count
        else {
            return nil
            
        }
        guard let currentVC = storyboard?.instantiateViewController(withIdentifier: "CurrentWeatherVC") as? CurrentWeatherViewController else { return nil }
        
        currentVC.city = savedCities[index]
        currentPage = index
        
        return currentVC
    }
}

extension PageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        return showCurrentViewControllerAtIndex(currentPage - 1)
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        return showCurrentViewControllerAtIndex(currentPage + 1)
    }
}
