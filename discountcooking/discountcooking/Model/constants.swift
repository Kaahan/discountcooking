//
//  constants.swift
//  discountcooking
//
//  Created by Kaahan Radia on 10/16/17.
//  Copyright © 2017 Kaahan Radia. All rights reserved.
//

import Foundation
import UIKit


var colors: [String: UIColor] = ["blueberry": hexStringToUIColor(hex: "6B7A8F"), "citrus": hexStringToUIColor(hex: "F7C331"), "apricot": hexStringToUIColor(hex: "F7882F"), "applecore": hexStringToUIColor(hex: "DCC7AA")]


//segues

var loginToMain = "loginToMain";
var signupToMain = "signupToMain";


//Nodes

var firUsersNode = "Users"
var firRecipesNode = "Recipes"
var firDoneRecipesNode = "doneRecipes"
var firCouponsNode = "Coupons"
var firUserCouponsNode = "Coupons"
var firRestaurantsNode = "Restaurants"
var firStorageImagesPath = "Images"

let imageCache = NSCache<NSString, UIImage>()
