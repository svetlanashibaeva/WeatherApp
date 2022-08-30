//
//  PageControllViewController.swift
//  WeatherApp
//
//  Created by Света Шибаева on 30.08.2022.
//

import UIKit

protocol CurrentWeatherPageContainerDelegate: AnyObject {
    func showSelectedPage(at index: Int)
}

class PageControlViewController: UIViewController {
    
    @IBOutlet weak var pageControl: UIPageControl!
    weak var delegate: CurrentWeatherPageContainerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let pageVC = children.first as? PageViewController else { return }
        pageVC.currentWeatherDelegate = self
        delegate = pageVC
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        do {
            pageControl.numberOfPages = (try CoreDataService.shared.context.fetch(CityEntity.fetchRequest())).count
        } catch let error as NSError{
            print(error.localizedDescription)
        }
    }
    
    @IBAction func changeDots(_ sender: UIPageControl) {
        delegate?.showSelectedPage(at: sender.currentPage)
    }
}

extension PageControlViewController: CurrentWeatherPageDelegate {
    
    func updateCurrentPage(index: Int) {
        pageControl.currentPage = index
    }
}
