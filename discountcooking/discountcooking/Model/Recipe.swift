//
//  Recipe.swift
//  discountcooking
//
//  Created by Kaahan Radia on 10/16/17.
//  Copyright © 2017 Kaahan Radia. All rights reserved.
//

import Foundation
import UIKit

class Recipe {
    internal var name: String
    internal var prepTime: Int
    internal var ingredients: [String]
    internal var directions: [String]
    internal var restaurant: Restaurant
    init(name: String, prepTime: Int, ingredients: [String], directions: [String], restaurant: Restaurant) {
        self.name = name
        self.prepTime = prepTime
        self.ingredients = ingredients
        self.directions = directions
        self.restaurant = restaurant
    }
    
    func getName() -> String {
        return self.name
    }
    func getPrepTime() -> Int {
        return self.prepTime
    }
    func getIngredients() -> [String] {
        return self.ingredients
    }
    func getDirections() -> [String] {
        return self.directions
    }
    func getRestaurant() -> Restaurant {
        return self.restaurant
    }
}
