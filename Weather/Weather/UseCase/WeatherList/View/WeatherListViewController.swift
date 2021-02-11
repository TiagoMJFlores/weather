//
//  ViewController.swift
//  Weather
//
//  Created by Tiago Flores on 11/02/2021.
//

import UIKit

class WeatherListViewController: UIViewController {

    private let cellHeight: CGFloat = 230
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(WeatherDaysTableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    
    private lazy var searchController: UISearchController = {
        let s =   UISearchController()
        s.definesPresentationContext = true
        s.searchResultsUpdater = self
        s.obscuresBackgroundDuringPresentation = false
        s.searchBar.placeholder = "Search"
        s.searchBar.searchBarStyle = .prominent
        return s
    }()
        
  
    
    let presenter: WeatherListProtocol
    
    init(presenter: WeatherListProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("not using storyboards")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addView()
        configureLayout()
        tableView.reloadData()
    }
    
    private func configureLayout() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
    
    private func addView() {
        view.addSubview(tableView)
        self.navigationItem.searchController = self.searchController
        self.navigationItem.hidesSearchBarWhenScrolling = false
    }

}


// MARK: UITableViewDataSource
extension WeatherListViewController: UITableViewDataSource {
    
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return presenter.numberItems()
  }
    
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? WeatherDaysTableViewCell else {
        return UITableViewCell()
    }
    cell.configure()
  
    return cell
  }
    
  
}


// MARK: UITableViewDelegate
extension WeatherListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
    
}

// MARK: UISearchResultsUpdating
extension WeatherListViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    
}


// MARK: WeatherViewReceiver
extension WeatherListViewController: WeatherViewReceiver {
    
}


