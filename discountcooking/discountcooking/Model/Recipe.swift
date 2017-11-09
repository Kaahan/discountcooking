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
    var done: Bool = false
    var description: String = ""
    var imagePath: String = ""
    init() {
        
    }
    func dictToRecipe(dict: [String:Any?], isDone: Bool) {
        name = dict["name"] as! String
        if let prepTime = dict["prepTime"] as? String {
            self.prepTime = Int(prepTime)!
        }
        ingredients =  dict["ingredients"] as! [String]
        directions = dict["directions"] as! [String]
        restaurantID = dict["restaurantID"] as! String
        description = dict["description"] as! String
        imagePath = dict["imagePath"] as! String
        done = isDone
    }
    func recipeToDict(recipe: Recipe) -> [String:Any?]{
        return ["name": recipe.name, "prepTime": String(describing: recipe.prepTime), "ingredients": recipe.ingredients, "directions": recipe.directions, "restaurantID": recipe.restaurantID, "description": recipe.description, "imagePath": recipe.imagePath]
    }
}
