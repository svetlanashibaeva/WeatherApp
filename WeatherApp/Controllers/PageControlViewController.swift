//
//  PageControllViewController.swift
//  WeatherApp
//
//  Created by Света Шибаева on 30.08.2022.
//

import UIKit

class PageControlViewController: UIViewController {
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    private var savedCities = [City]()
    private var currentPage = 0
    private var pageVC: UIPageViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        updateSavedCities()

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
        
        currentVC.city = index != 0 ? savedCities[index - 1] : nil
        
        return currentVC
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowSearch" {
            let searchVC = segue.destination as! SearchViewController
            searchVC.delegate = self
        }   
    }
    
    private func setCurrentPage(viewControllers: [UIViewController]) {
        guard let currentVC = viewControllers.first as? CurrentWeatherViewController else { return }
        let index = Int(savedCities.firstIndex { currentVC.city == $0 } ?? -1)
        currentPage = index + 1
        pageControl.currentPage = index + 1
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
        setCurrentPage(viewControllers: pendingViewControllers)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard !completed else { return }
        setCurrentPage(viewControllers: previousViewControllers)
    }
}

extension PageControlViewController: SearchControllerDelegate {
    
    func updateSavedCities() {
        let cities = (try? CoreDataService.shared.context.fetch(CityEntity.fetchRequest())) ?? []
        savedCities = cities.map { City(from: $0) }
        pageControl.numberOfPages = cities.count + 1
    }

    func showSelectedPage(at index: Int) {
        guard let currentWeatherVC = showCurrentViewControllerAtIndex(index) else { return }
        pageVC?.setViewControllers([currentWeatherVC], direction: .forward, animated: true, completion: nil)
        currentPage = index
        pageControl.currentPage = index
    }
}
