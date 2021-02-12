//
//  WeatherDatCollectionViewCell.swift
//  Weather
//
//  Created by Tiago Flores on 11/02/2021.
//

import UIKit

class WeatherDayCollectionViewCell: UICollectionViewCell {
    
    private var presenter: WeatherDayPresenterProtocol?
 
    private (set) lazy var titleTextLabel: UILabel = {
        let titleTextLabel = UILabel()
        titleTextLabel.numberOfLines = 0
        titleTextLabel.lineBreakMode = .byWordWrapping
        titleTextLabel.textColor = UIColor.black
        return titleTextLabel
    }()
    
    private (set) lazy var weatherImageView: UIImageView = {
        let weatherImageView = UIImageView()
        weatherImageView.layer.cornerRadius = weatherImageView.frame.width / 2
        weatherImageView.clipsToBounds = true
        weatherImageView.contentMode = .scaleAspectFit
        weatherImageView.backgroundColor = .white
        return weatherImageView
    }()
    
   
    private (set) lazy var horizontalStackView: UIStackView = {
        let stackView = UIStackView()
        let spacerView = UIView()
      
        stackView.axis  = .vertical
        stackView.distribution  = .fill
        stackView.alignment = .top
        //stackView.spacing   = 8

        contentView.addSubview(stackView)
        return stackView
    }()
        

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    private func configureLayout() {
        titleTextLabel.translatesAutoresizingMaskIntoConstraints = false
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            horizontalStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            horizontalStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            horizontalStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            horizontalStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
           
        ])
        
        horizontalStackView.addArrangedSubview(weatherImageView)
        horizontalStackView.addArrangedSubview(titleTextLabel)
        horizontalStackView.layoutIfNeeded()
        
        let titleHeightConstraint = titleTextLabel.heightAnchor.constraint(equalTo: horizontalStackView.heightAnchor)
        titleHeightConstraint.priority = UILayoutPriority(rawValue: 999)
        titleHeightConstraint.isActive = true
        let imageWidthConstraint = weatherImageView.heightAnchor.constraint(equalToConstant: 80)
        imageWidthConstraint.priority = UILayoutPriority(rawValue: 999)
        imageWidthConstraint.isActive = true
    }
    
    func configure(indexPath: IndexPath, with presenter: WeatherDayPresenterProtocol) {

        titleTextLabel.text = presenter.weatherDataStr(indexPath: indexPath)
        presenter.downloadImage(indexPath: indexPath) { [weak self] image in
                guard let self = self else {
                    return
                }
                self.weatherImageView.image = image
        }
    }
}
