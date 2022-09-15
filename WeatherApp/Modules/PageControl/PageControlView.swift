//
//  PageControlView.swift
//  WeatherApp
//
//  Created by Света Шибаева on 12.09.2022.
//

import UIKit

class PageControlView: UIView {
    
    let pageControl = UIPageControl()
    let pageVC = UIPageViewController()
    let listButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
        addSubviews()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension PageControlView {
    
    func configure() {
        backgroundColor = .defaultBackground
        pageControl.pageIndicatorTintColor = .gray
        pageControl.currentPageIndicatorTintColor = .blue
        
        listButton.tintColor = .blue
        listButton.setBackgroundImage(UIImage(systemName: "list.triangle"), for: .normal)
    }
    func addSubviews() {
        addSubview(pageVC.view)
        pageVC.view.translatesAutoresizingMaskIntoConstraints = false
        
        [pageControl, listButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
    }
    
    func makeConstraints() {
        NSLayoutConstraint.activate([
            pageVC.view.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            pageVC.view.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            pageVC.view.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            
            pageControl.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            pageControl.topAnchor.constraint(equalTo: pageVC.view.bottomAnchor, constant: 16),
            pageControl.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -8),
            
            listButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            listButton.leadingAnchor.constraint(greaterThanOrEqualTo: pageControl.trailingAnchor, constant: 8),
            listButton.centerYAnchor.constraint(equalTo: pageControl.centerYAnchor),
            listButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -8),
            listButton.widthAnchor.constraint(equalToConstant: 24),
            listButton.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
}
