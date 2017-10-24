//
//  Coupon.swift
//  discountcooking
//
//  Created by Kaahan Radia on 10/17/17.
//  Copyright © 2017 Kaahan Radia. All rights reserved.
//

import Foundation

class Coupon {
    
    var value: Int
    var percent: Float
    internal var restaurant: Restaurant
    internal var recipes: [Recipe]
    
    
    init(value: Int = 0, percent: Float = 0.0, restaurant: Restaurant, recipes: [Recipe]) {
        self.value = value
        self.percent = percent
        self.restaurant = restaurant
        self.recipes = recipes
    }
    
    func getRestaurant() -> Restaurant {
        return self.restaurant
    }
    func getRecipes() -> [Recipe] {
        return self.recipes
    }
    
}
