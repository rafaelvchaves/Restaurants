//
//  Restaurant.swift
//  rvc29_p5
//
//  Created by Rafael Chaves on 10/29/19.
//  Copyright © 2019 Rafael Chaves. All rights reserved.
//

import Foundation


enum category: String {
    case Mexican
    case Asian
    case American
    case Italian
    case FastFood
    case Japanese
}

enum mealTime: String {
    case Breakfast
    case Lunch
    case Dinner
}

class Restaurant {
    
    var name: String
    var price: String
    var categories: [category]
    var mealTimes: [mealTime]
    var imageString: String
    
    
    init(name: String, price: String, categories: [category], mealTimes: [mealTime], imageString: String) {
        self.name = name
        self.price = price
        self.categories = categories
        self.mealTimes = mealTimes
        self.imageString = imageString
        
    }
    
    func getCategory(category: category) -> String {
        switch category {
        case .Mexican:
            return "Mexican"
        case .Asian:
            return "Asian"
        case .American:
            return "American"
        case .Italian:
            return "Italian"
        case .FastFood:
            return "Fast Food"
        case .Japanese:
            return "Japanese"
        }
        
    }
    
    func getCategoriesString() -> String {
        var result: String = ""
        for c in categories {
            result += getCategory(category: c)
            if c != categories.last {
                result += ", "
            }
        }
        return result
    }
    
    func getMealTime(mealTime: mealTime) -> String {
        switch mealTime {
        case .Breakfast:
            return "Breakfast"
        case .Lunch:
            return "Lunch"
        case .Dinner:
            return "Dinner"
        }
    }
    
    func getMealTimesString() -> String {
        var result: String = ""
        for m in mealTimes {
            result += getMealTime(mealTime: m)
            if m != mealTimes.last {
                result += ", "
            }
        }
        return result
    }
    
    func categoryString() -> [String] {
        var res: [String] = []
        for c in categories {
            res.append(getCategory(category: c))
        }
        return res
    }
    
    func mealTimeString() -> [String] {
        var res: [String] = []
        for m in mealTimes {
            res.append(getMealTime(mealTime: m))
        }
        return res
    }
    
    func hasFilter(filters: [String]) -> Bool {
        if filters.count == 0 {
            return true
        }
        for filter in filters {
            if categoryString().contains(filter) || mealTimeString().contains(filter) {
                return true
            }
        }
        return false
    }
    
}
