//
//  ViewController.swift
//  rvc29_p5
//
//  Created by Rafael Chaves on 10/29/19.
//  Copyright © 2019 Rafael Chaves. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var restaurantCollectionView: UICollectionView!
    var filterBarCollectionView: UICollectionView!
    var backgroundColor: UIColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    
    let restaurantCellReuseIdentifier = "restaurantCellReuseIdentifier"
    let filterBarReuseIdentifier = "filterBarReuseIdentifier"
    let padding: CGFloat = 10
    let headerHeight: CGFloat = 30
    
    var originalRestaurants: [Restaurant] = []
    var restaurants: [Restaurant] = []
    var filterNames: [Filter] = []
    var selectedFilters: Set<String> = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "My Restaurants"
        view.backgroundColor = backgroundColor
        
        
        
        let chipotle = Restaurant(name: "Chipotle", price: "$", categories: [.Mexican, .FastFood], mealTimes: [.Lunch, .Dinner], imageString: "chipotle")
        let chickfila = Restaurant(name: "Chick-fil-A", price: "$", categories: [.American, .FastFood], mealTimes: [.Lunch, .Dinner], imageString: "chickfila")
        let tacobell = Restaurant(name: "Taco Bell", price: "$", categories: [.Mexican, .FastFood], mealTimes: [.Lunch, .Dinner], imageString: "tacobell")
        let takara = Restaurant(name: "Takara", price: "$$", categories: [.Asian, .Japanese], mealTimes: [.Lunch, .Dinner], imageString: "takara")
        
        originalRestaurants = [chipotle, chickfila, tacobell, chipotle, takara, chipotle, chickfila, tacobell, chipotle, takara]
        restaurants = originalRestaurants
        
        filterNames = [Filter(name: "Asian"), Filter(name: "Mexican"), Filter(name: "American"), Filter(name: "Fast Food"), Filter(name: "Seafood"), Filter(name: "Italian"), Filter(name: "Korean"), Filter(name: "Breakfast"), Filter(name: "Lunch"), Filter(name: "Dinner")]
        
        let restaurantLayout = UICollectionViewFlowLayout()
        restaurantLayout.scrollDirection = .vertical
        restaurantLayout.minimumLineSpacing = padding
        restaurantLayout.minimumInteritemSpacing = padding
        
        let filterBarLayout = UICollectionViewFlowLayout()
        filterBarLayout.scrollDirection = .horizontal
        filterBarLayout.minimumLineSpacing = padding
        filterBarLayout.minimumInteritemSpacing = padding
        
        restaurantCollectionView = UICollectionView(frame: .zero, collectionViewLayout: restaurantLayout)
        setupCollectionView(collectionView: restaurantCollectionView, cell: RestaurantCollectionViewCell.self, reuseIdentifier: restaurantCellReuseIdentifier)
        restaurantCollectionView.isUserInteractionEnabled = true
        
        filterBarCollectionView = UICollectionView(frame: .zero, collectionViewLayout: filterBarLayout)
        filterBarCollectionView.delegate = self
        filterBarCollectionView.dataSource = self
        setupCollectionView(collectionView: filterBarCollectionView, cell: FilterCollectionViewCell.self, reuseIdentifier: filterBarReuseIdentifier)
        filterBarCollectionView.isUserInteractionEnabled = true
        
        setupConstraints()
    }
    
    func setupCollectionView(collectionView: UICollectionView, cell: AnyClass?, reuseIdentifier: String) {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = backgroundColor
        collectionView.register(cell, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        view.addSubview(collectionView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            filterBarCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            filterBarCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            filterBarCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            filterBarCollectionView.heightAnchor.constraint(equalToConstant: headerHeight)
        ])
        NSLayoutConstraint.activate([
            restaurantCollectionView.topAnchor.constraint(equalTo: filterBarCollectionView.bottomAnchor, constant: padding),
            restaurantCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            restaurantCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            restaurantCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionView == filterBarCollectionView ? filterNames.count : restaurants.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == filterBarCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: filterBarReuseIdentifier, for: indexPath) as! FilterCollectionViewCell
            cell.changeName(for: filterNames[indexPath.row].name)
            cell.changeColor(toggled: filterNames[indexPath.row].isSelected)
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: restaurantCellReuseIdentifier, for: indexPath) as! RestaurantCollectionViewCell
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 5
        cell.configure(for: restaurants[indexPath.row])
        return cell
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == filterBarCollectionView {
            let width = CGFloat(filterNames[indexPath.row].name.count) * 15.0
            return CGSize(width: width, height: collectionView.frame.height)
        }
        let size = (collectionView.frame.width - padding) / 2.0
        return CGSize(width: size, height: size)
    }
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == filterBarCollectionView {
            let filter = filterNames[indexPath.row]
            filter.isSelected.toggle()
            if filter.isSelected {
                selectedFilters.insert(filter.name)
            }
            else {
                selectedFilters.remove(filter.name)
            }
            restaurants = selectedFilters.count > 0 ? originalRestaurants.filter {$0.hasFilter(filters: Array(selectedFilters))} : originalRestaurants
            restaurantCollectionView.reloadData()
            filterBarCollectionView.reloadData()
        }
        
    }
}

