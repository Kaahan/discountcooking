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
    
    var name: String = ""
    var prepTime: Int? = 0
    var ingredients: [String] = []
    var directions: [String] = []
    var restaurantID: String = ""
    var done: Bool = false
    var description: String = ""
    init() {
        
    }
    func dictToRestaurant(dict: [String:Any?], isDone: Bool) {
        name = dict["name"] as! String
        prepTime = Int(dict["prepTime"] as! String)
        ingredients =  dict["ingredients"] as! [String]
        directions = dict["directions"] as! [String]
        restaurantID = dict["restaurantID"] as! String
        description = dict["description"] as! String
        done = isDone
    }
    
}
