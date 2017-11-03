//
//  RecipeFeed.swift
//  discountcooking
//
//  Created by Kaahan Radia on 10/25/17.
//  Copyright © 2017 Kaahan Radia. All rights reserved.
//

import Foundation
import FirebaseStorage
import FirebaseDatabase




func getRecipes(user: CurrentUser, completion: @escaping ([Recipe]?) -> Void) {
    let dbRef = Database.database().reference()
    var recipesArray: [Recipe] = []
    dbRef.child(firRecipesNode).observeSingleEvent(of: .value, with: { snapshot -> Void in
        if snapshot.exists() {
            if let recipes = snapshot.value as? [String:AnyObject] {
                user.getDoneRecipes(completion: { (doneRecipes) in
                    for key in recipes.keys {
                        if let recipe = recipes[key] as? [String:Any] {
                            var newRecipe = Recipe()
                            newRecipe.dictToRestaurant(dict: recipe, isDone: doneRecipes.contains(key))
                            recipesArray.append(newRecipe)
                            
                        }
                    }
                    completion(recipesArray)
                })
            } else {
                completion(nil)
            }
        } else {
            completion(nil)
        }
    })
}
func getRestaurant(id: String, completion: @escaping (Restaurant?) -> Void) {
    let dbRef = Database.database().reference()
    dbRef.child(firRestaurantsNode).observeSingleEvent(of: .value) { (snapshot) in
        if snapshot.exists() {
            if let restaurants = snapshot.value as? [String:AnyObject] {
                for key in restaurants.keys {
                    if let returnedrestaurant = restaurants[key] as? [String:Any] {
                        if key == id {
                            var restaurant = Restaurant()
                            restaurant.dictToRestaurant(id: key, dict: returnedrestaurant)
                            completion(restaurant)
                        }
                    }
                }
            } else {
                completion(nil)
            }
        } else {
            completion(nil)
        }
    }
}
func getRecipe(id: String, completion: @escaping (Recipe?) -> Void) {
    let dbRef = Database.database().reference()
    dbRef.child(firRecipesNode).observeSingleEvent(of: .value) { (snapshot) in
        if snapshot.exists() {
            if let recipes = snapshot.value as? [String:AnyObject] {
                for key in recipes.keys {
                    if let returnedrecipe = recipes[key] as? [String:Any] {
                        if key == id {
                            var recipe = Recipe()
                            recipe.dictToRestaurant(dict: returnedrecipe, isDone: false)
                            completion(recipe)
                        }
                    }
                    
                }
            } else {
                completion(nil)
            }
        } else {
            completion(nil)
        }
    }
}

