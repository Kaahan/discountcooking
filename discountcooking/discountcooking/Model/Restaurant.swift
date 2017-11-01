//
//  Restaurant.swift
//  discountcooking
//
//  Created by Kaahan Radia on 10/17/17.
//  Copyright © 2017 Kaahan Radia. All rights reserved.
//

import Foundation

class Restaurant {
    var name: String
    var recipes: [Recipe]
    var restaurantID: String
    
    init(id: String, name: String, recipes: [Recipe]) {
        self.restaurantID = id
        self.name = name
        self.recipes = recipes
    }
    
    
}
