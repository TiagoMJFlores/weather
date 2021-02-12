//
//  ViewController.swift
//  Weather
//
//  Created by Tiago Flores on 11/02/2021.
//

import UIKit

final class WeatherListViewController: UIViewController {

    private let cellHeight: CGFloat = 230
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(WeatherDaysTableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    
    private lazy var searchController: UISearchController = {
        let searchController =   UISearchController()
        searchController.definesPresentationContext = true
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        searchController.searchBar.searchBarStyle = .prominent
        return searchController
    }()
        
  
    let presenter: WeatherListPresenterProtocol
    
    init(presenter: WeatherListPresenterProtocol) {
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
        presenter.viewWasLoaded()
    }
    
    private func configureLayout() {
        setupBarButtonItem()
        setupTableView() 
    }
    
    private func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
    
    private func setupBarButtonItem() {
        let offLabel = UILabel()
        offLabel.font = UIFont.boldSystemFont(ofSize: UIFont.smallSystemFontSize)
        offLabel.text = "OFF"

        let onLabel = UILabel()
        onLabel.font = UIFont.boldSystemFont(ofSize: UIFont.smallSystemFontSize)
        onLabel.text = "ON"

        let toggle = UISwitch()
        toggle.addTarget(self, action: #selector(toggleValueChanged(_:)), for: .valueChanged)

        let stackView = UIStackView(arrangedSubviews: [offLabel, toggle, onLabel])
        stackView.spacing = 8

        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: stackView)
    }

    @objc func toggleValueChanged(_ toggle: UISwitch) {
        presenter.toggle(changeTo: toggle.isOn)
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
    let itemPresenter = presenter.item(at: indexPath)
    cell.configure(presenter: itemPresenter)
  
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
        let searchText = searchController.searchBar.text ?? ""
        presenter.search(searchText: searchText)
    }
    
}


// MARK: WeatherViewReceiver
extension WeatherListViewController: WeatherViewReceiver {
    
    func reloadData() {
        tableView.reloadData()
    }
    
}


