//
//  PageControllViewController.swift
//  WeatherApp
//
//  Created by Света Шибаева on 30.08.2022.
//

import UIKit

extension PageControlViewController {
    
    struct Dependencies {
        let coreDataService: CoreDataServiceProtocol
    }
}

class PageControlViewController: UIViewController {
    
    private let customView = PageControlView()
    
    private var savedCities = [City]()
    private var currentPage = 0
    
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
 
        updateSavedCities()
        addChild(customView.pageVC)
        customView.pageVC.didMove(toParent: self)
        
        customView.pageVC.dataSource = self
        customView.pageVC.delegate = self
        
        customView.listButton.addTarget(self, action: #selector(showSavedList), for: .touchUpInside)
        customView.pageControl.addTarget(self, action: #selector(changeDots), for: .touchUpInside)
        
        showSelectedPage(at: currentPage)
    }
    
    @objc func showSavedList() {
        let searchController = ModuleFactory.shared.searchModule()
        searchController.delegate = self
        searchController.modalPresentationStyle = .fullScreen
        
        present(searchController, animated: true)
    }
    
    @objc func changeDots(_ sender: UIPageControl) {
        showSelectedPage(at: sender.currentPage)
    }
    
    private func showCurrentViewControllerAtIndex(_ index: Int) -> CurrentWeatherViewController? {
        guard index >= 0 else { return nil }
        guard index < savedCities.count + 1
        else {
            return nil
        }
        
        let currentVC = ModuleFactory.shared.currentWeatherModule()
        currentVC.city = index != 0 ? savedCities[index - 1] : nil
        
        return currentVC
    }
    
    private func setCurrentPage(viewControllers: [UIViewController]) {
        guard let currentVC = viewControllers.first as? CurrentWeatherViewController else { return }
        let index = Int(savedCities.firstIndex { currentVC.city == $0 } ?? -1)
        currentPage = index + 1
        customView.pageControl.currentPage = index + 1
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
        let cities = dp.coreDataService.getCities()
        savedCities = cities.map { City(from: $0) }
        customView.pageControl.numberOfPages = cities.count + 1
    }

    func showSelectedPage(at index: Int) {
        guard let currentWeatherVC = showCurrentViewControllerAtIndex(index) else { return }
        customView.pageVC.setViewControllers([currentWeatherVC], direction: .forward, animated: true, completion: nil)
        currentPage = index
        customView.pageControl.currentPage = index
    }
}
