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
    var prepTime: Int = 0
    var ingredients: [String] = []
    var directions: [String] = []
    var restaurantID: String = ""
    var recipeID: String?
    var description: String = ""
    var imagePath: String = ""
    init() {
        
    }
    func dictToRecipe(dict: [String:Any?], key: String) {
        name = dict["name"] as! String
        if let prepTime = dict["prepTime"] as? String {
            self.prepTime = Int(prepTime)!
        }
        recipeID = key
        ingredients =  dict["ingredients"] as! [String]
        directions = dict["directions"] as! [String]
        restaurantID = dict["restaurantID"] as! String
        description = dict["description"] as! String
        imagePath = dict["imagePath"] as! String
    }
    func recipeToDict(recipe: Recipe) -> [String:Any?]{
        return ["name": recipe.name, "prepTime": String(describing: recipe.prepTime), "ingredients": recipe.ingredients, "directions": recipe.directions, "restaurantID": recipe.restaurantID, "description": recipe.description, "imagePath": recipe.imagePath]
    }
    func stringprepTime() -> String {
        if self.prepTime > 60 {
            return "\(Int(self.prepTime/60)):\(self.prepTime%60)"
        } else {
            return "\(self.prepTime)"
        }
    }
}
