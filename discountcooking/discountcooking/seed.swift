//
//  seed.swift
//  discountcooking
//
//  Created by Kaahan Radia on 10/18/17.
//  Copyright © 2017 Kaahan Radia. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseStorage

func seedDatabase() {
    let dbRef = Database.database().reference()
    
    let restaurantdict: [String:Any] = ["name": "La Burrita", "coupons": ["empty"], "recipes": ["empty"]]
    dbRef.child(firRestaurantsNode).childByAutoId().setValue(restaurantdict)
    
    
    
    let recipedict: [String:Any?] = ["name": "enchillada", "prepTime": "40", "ingredients": ["beans", "cheese", "tortilla", "sauce"], "directions": ["put stuff in tortilla", "cover in sauce", "put in oven", "eat"],
                "restaurantID": "1", "description": "delicious mexican dish made easy"]

    dbRef.child(firRecipesNode).childByAutoId().setValue(recipedict)
    
    
}
