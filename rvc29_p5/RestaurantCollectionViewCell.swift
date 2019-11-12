//
//  RestaurantCollectionViewCell.swift
//  rvc29_p5
//
//  Created by Rafael Chaves on 10/29/19.
//  Copyright © 2019 Rafael Chaves. All rights reserved.
//

import UIKit

class RestaurantCollectionViewCell: UICollectionViewCell {
    
    var photoImageView: UIImageView!
    
    var restaurantNameLabel: UILabel = UILabel()
    var costLabel: UILabel = UILabel()
    var informationLabel: UILabel = UILabel()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = .white
        addLabel(label: restaurantNameLabel)
        addLabel(label: costLabel)
        addLabel(label: informationLabel)
        
        photoImageView = UIImageView()
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        photoImageView.contentMode = .scaleAspectFill
        photoImageView.layer.masksToBounds = true
        photoImageView.layer.cornerRadius = 5
        contentView.addSubview(photoImageView)
        
        setupConstraints()
    }
    
    func addLabel(label: UILabel!) {
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(label)
    }
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            informationLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 3),
            informationLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            informationLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -3)
        ])
        
        NSLayoutConstraint.activate([
            restaurantNameLabel.bottomAnchor.constraint(equalTo: informationLabel.topAnchor),
            restaurantNameLabel.leadingAnchor.constraint(equalTo: informationLabel.leadingAnchor),
        ])
        
        NSLayoutConstraint.activate([
            costLabel.topAnchor.constraint(equalTo: restaurantNameLabel.topAnchor),
            costLabel.trailingAnchor.constraint(equalTo: informationLabel.trailingAnchor, constant: -3)
        ])
        
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            photoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            photoImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            photoImageView.bottomAnchor.constraint(equalTo: restaurantNameLabel.topAnchor, constant: -3)
        ])
        
    }
    
    func configure(for restaurant: Restaurant) {
        photoImageView.image = UIImage(named: restaurant.imageString)
        restaurantNameLabel.text = restaurant.name
        costLabel.text = restaurant.price
        informationLabel.text = restaurant.getCategoriesString() + "  •  " + restaurant.getMealTimesString()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
