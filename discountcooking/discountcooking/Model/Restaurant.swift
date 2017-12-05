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
    var recipes: [String] = []
    var restaurantID: String = ""
    var verified: Bool = false
    var phone: String = ""
    init() {
       
    }
    
    func dictToRestaurant(id: String, dict: [String:Any?]) {
        self.name = dict["name"] as! String
        self.recipes = dict["recipes"] as! [String]
        self.verified = dict["verified"] as! Bool
        self.restaurantID = id
        self.phone = dict["phone"] as! String
    }
    
}
