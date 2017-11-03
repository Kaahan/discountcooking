//
//  Restaurant.swift
//  discountcooking
//
//  Created by Kaahan Radia on 10/17/17.
//  Copyright © 2017 Kaahan Radia. All rights reserved.
//

import Foundation

class Restaurant {
    var name: String = ""
    var recipes: [Recipe] = []
    var restaurantID: String = ""
    
    init() {
       
    }
    
    func dictToRestaurant(id: String, dict: [String:Any?]) {
        self.name = dict["name"] as! String
        for recipe in dict["recipes"] as! [String] {
            getRecipe(id: recipe, completion: {(returnedrecipe) in
                self.recipes.append(returnedrecipe!)
            })
        }
        self.restaurantID = id
    }
    
}
