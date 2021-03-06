//
//  WeatherDayTableViewCell.swift
//  Weather
//
//  Created by Tiago Flores on 11/02/2021.
//

import UIKit

final class WeatherDaysTableViewCell: UITableViewCell {

    private let collectionInsets: CGFloat = 16
    private var presenter: WeatherDayPresenterProtocol?
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center;
        label.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(label)
        label.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        label.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        label.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        return label
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
         layout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: self.contentView.bounds, collectionViewLayout: layout)
         collection.collectionViewLayout = layout
         collection.showsHorizontalScrollIndicator = false
         collection.isPagingEnabled = true
         collection.register(WeatherDayCollectionViewCell.self, forCellWithReuseIdentifier: "WeatherDayCollectionViewCell")
        collection.dataSource = self
        collection.delegate = self
        collection.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(collection)
        collection.topAnchor.constraint(equalTo: titleLabel.bottomAnchor).isActive = true
        collection.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        collection.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        collection.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        return collection
    }()
    
    func configure(presenter: WeatherDayPresenterProtocol) {
        self.presenter = presenter
        collectionView.reloadData()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension WeatherDaysTableViewCell: UICollectionViewDelegate,  UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.numberItems() ?? 0
    }
    

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeatherDayCollectionViewCell", for: indexPath) as? WeatherDayCollectionViewCell,
              let presenter = presenter else {
            return UICollectionViewCell()
        }
  
        cell.backgroundColor = UIColor.gray
        cell.largeContentTitle = "sdss"
        titleLabel.text = presenter.weatherData.day
        cell.configure( indexPath: indexPath, with: presenter)
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: contentView.bounds.width - collectionInsets * 2, height: contentView.bounds.height-collectionInsets * 2)
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt  section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets.init(top: collectionInsets, left: collectionInsets, bottom: collectionInsets, right: collectionInsets)
    }
    
}
