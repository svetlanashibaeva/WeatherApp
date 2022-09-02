//
//  PageControllViewController.swift
//  WeatherApp
//
//  Created by Света Шибаева on 30.08.2022.
//

import UIKit

class PageControlViewController: UIViewController {
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var listButton: UIButton!
    
    private var savedCities = [City]()
    private var currentPage = 0
    private var pageVC: UIPageViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cities = (try? CoreDataService.shared.context.fetch(CityEntity.fetchRequest())) ?? []
        savedCities = cities.map { City(from: $0) }
        pageControl.numberOfPages = cities.count + 1

        pageVC = children.first as? UIPageViewController
        pageVC?.dataSource = self
        pageVC?.delegate = self
        
        showSelectedPage(at: currentPage)
    }
    
    @IBAction func changeDots(_ sender: UIPageControl) {
        showSelectedPage(at: sender.currentPage)
    }
    
    private func showCurrentViewControllerAtIndex(_ index: Int) -> CurrentWeatherViewController? {
        guard index >= 0 else { return nil }
        guard index < savedCities.count + 1
        else {
            return nil
        }
        guard let currentVC = storyboard?.instantiateViewController(withIdentifier: "CurrentWeatherVC") as? CurrentWeatherViewController else { return nil }
        
        if index != 0 {
            currentVC.city = savedCities[index - 1]
        } else {
            currentVC.city = nil
        }
        
        return currentVC
    }
    
    private func showSelectedPage(at index: Int) {
        guard let currentWeatherVC = showCurrentViewControllerAtIndex(index) else { return }
        pageVC?.setViewControllers([currentWeatherVC], direction: .forward, animated: true, completion: nil)
    }
}

extension PageControlViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        return showCurrentViewControllerAtIndex(currentPage - 1)
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        return showCurrentViewControllerAtIndex(currentPage + 1)
    }
}

extension PageControlViewController: UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        guard let currentVC = pendingViewControllers.first as? CurrentWeatherViewController else { return }
        let index = Int(savedCities.firstIndex { currentVC.city == $0 } ?? -1)
        currentPage = index + 1
        pageControl.currentPage = index + 1
    }
}
