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
import UIKit
func seedDatabase() {
    let dbRef = Database.database().reference()
//
//    let restaurantdict: [String:Any] = ["name": "La Burrita", "coupons": ["empty"], "recipes": ["empty"]]
//    dbRef.child(firRestaurantsNode).childByAutoId().setValue(restaurantdict)
//
//
//    
    let recipedict: [String:Any?] = ["name": "enchillada", "prepTime": "40", "ingredients": ["beans", "cheese", "tortilla", "sauce"], "directions": ["put stuff in tortillaasaasdpiasnduinailudnaiundwiunaliusndwjawiudnlaksjndwualnkwjndkajsnjkwnauinlkjsndiuwakljsnduwaliknjsdwuailknsjdnwauiskjndlwajkn", "cover in sauce", "put in oven", "eat"],
                "restaurantID": "1", "description": "delicious mexican dish made easy"]
    let recipedict2: [String:Any?] = ["name": "Crock Pot Roast",
                                      "prepTime": "480",
                                      "ingredients": [
                                        "beef roast",
                                        "brown gravy mix",
                                        "dried Italian salad dressing mix",
                                        "dry ranch dressing mix",
                                        "water"],
                                      "directions": [
                                        "Place beef roast in crock pot.",
                                        "Mix the dried mixes together in a bowl and sprinkle over the roast.",
                                        "Pour the water around the roast.",
                                        "Cook on low for 7-9 hours."],
                                      "restaurantID": "1",
                                      "description": "Delicious traditional american recipe",
                                      "isDone": false]
    let recipe = Recipe()
//    recipe.dictToRecipe(dict: recipedict2, key: "")
//    let url = URL(string:"https://www.laurengreutman.com/wp-content/uploads/2015/08/Pot-Roast-in-crockpot.png")
//    let data = try? Data(contentsOf: url!)
//    let image: UIImage = UIImage(data: data!)!
//    createRecipe(recipe: recipe, image: image)
    let coupondict: [String:Any?] = ["value": "2", "percent": "0.0", "recipes": ["empty"], "restaurant": "1"]
    let coupon = Coupon()
    coupon.dictToCoupon(dict: coupondict, key: "")
    createCoupon(coupon: coupon, restaurantID: CurrentUser().id)
}
