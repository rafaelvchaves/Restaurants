//
//  FilterBarView.swift
//  rvc29_p5
//
//  Created by Rafael Chaves on 11/3/19.
//  Copyright © 2019 Rafael Chaves. All rights reserved.
//

import UIKit

class FilterCollectionViewCell: UICollectionViewCell {
    var filter: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .white

        filter = UILabel()
        filter.translatesAutoresizingMaskIntoConstraints = false
        filter.layer.borderColor = UIColor.systemBlue.cgColor
        filter.textAlignment = .center
        filter.layer.borderWidth = 1
        filter.layer.cornerRadius = 5
        contentView.addSubview(filter)
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            filter.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            filter.topAnchor.constraint(equalTo: contentView.topAnchor),
            filter.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            filter.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func changeName(for filterName: String) {
        filter.text = filterName
    }
    
    func changeColor(toggled: Bool) {
        if toggled {
            filter.textColor = .white
            filter.backgroundColor = .systemBlue
        }
        else {
            filter.textColor = .systemBlue
            filter.backgroundColor = .white
        }
    }
    
}
