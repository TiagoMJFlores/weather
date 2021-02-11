//
//  ViewController.swift
//  Weather
//
//  Created by Tiago Flores on 11/02/2021.
//

import UIKit

class WeatherListViewController: UIViewController {

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(WeatherDayTableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
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
        tableView.reloadData()
    }


}


// MARK: UITableViewDataSource
extension WeatherListViewController: UITableViewDataSource {
    
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return presenter.numberItems()
  }
    
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? WeatherDayTableViewCell else {
        return UITableViewCell()
    }
    
  
    return cell
  }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
}



// MARK: WeatherViewReceiver
extension WeatherListViewController: WeatherViewReceiver {
    
}
