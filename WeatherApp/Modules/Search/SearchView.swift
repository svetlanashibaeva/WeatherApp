//
//  SearchView.swift
//  WeatherApp
//
//  Created by Света Шибаева on 12.09.2022.
//

import UIKit

class SearchView: UIView {
    
    let tableView = UITableView()
    let searchBar = UISearchBar()
    let activityIndicator = UIActivityIndicatorView()
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)

        configure()
        addSubviews()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension SearchView {
    
    func configure() {
        backgroundColor = .defaultBackground
        
        activityIndicator.style = .large
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        
        tableView.register(SearchCell.self, forCellReuseIdentifier: "SearchCell")
    }
    
    func addSubviews() {
        [tableView, searchBar, activityIndicator].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
    }
    
    func makeConstraints() {
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            
            activityIndicator.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor)
        ])
    }
}
