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
        backgroundColor = .white
        tableView.register(SearchCell.self, forCellReuseIdentifier: "SearchCell")
    }
    
    func addSubviews() {
        [tableView, searchBar].forEach {
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
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
