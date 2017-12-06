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
import UIKit



func getRecipes(key: String = "", user: CurrentUser, completion: @escaping ([Recipe]?, String) -> Void) {
    let dbRef = Database.database().reference()
    var recipesArray: [Recipe] = []
    dbRef.child(firRecipesNode).observeSingleEvent(of: .value, with: { snapshot -> Void in
        if snapshot.exists() {
            if let recipes = snapshot.value as? [String:AnyObject] {
                
                user.getDoneRecipes(completion: { (doneRecipes) in
                    for key in recipes.keys {
                        if doneRecipes[key] != nil {
                            continue
                        } else {
                            if let recipe = recipes[key] as? [String:Any] {
                                var newRecipe = Recipe()
                                newRecipe.dictToRecipe(dict: recipe, key: key)
                                recipesArray.append(newRecipe)
                                
                            }
                        }
                    }
                    completion(recipesArray, key)
                })
            } else {
                completion(nil, key)
            }
        } else {
            completion(nil, key)
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
                            recipe.dictToRecipe(dict: returnedrecipe, key: key)
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
func getCoupon(id: String, completion: @escaping (Coupon?) -> Void) {
    let dbRef = Database.database().reference()
    dbRef.child(firCouponsNode).observeSingleEvent(of: .value) { (snapshot) in
        if snapshot.exists() {
            if let coupons = snapshot.value as? [String:AnyObject] {
                for key in coupons.keys {
                    if let returnedcoupon = coupons[key] as? [String:Any] {
                        if key == id {
                            var coupon = Coupon()
                            coupon.dictToCoupon(dict: returnedcoupon, key: key)
                            completion(coupon)
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
func createRecipe(recipe: Recipe, image: UIImage, coupon: Coupon, restaurantID: String) {
    let dbRef = Database.database().reference()
    let uuid = NSUUID().uuidString
    recipe.imagePath = firStorageImagesPath + "/" + uuid
    let ref = dbRef.child(firRecipesNode).childByAutoId()
    ref.setValue(recipe.recipeToDict(recipe: recipe))
    var new_coupon_recipes = coupon.recipes
    new_coupon_recipes.append(ref.key)
    dbRef.child(firCouponsNode).child(coupon.couponID).updateChildValues(["recipes": new_coupon_recipes])
    var restaurant_recipes: [String] = []
    getRestaurant(id: restaurantID) { (restaurant) in
        restaurant_recipes = (restaurant?.recipes)!
        restaurant_recipes.append(ref.key)
        dbRef.child(firRestaurantsNode).child(restaurantID).updateChildValues(["recipes": restaurant_recipes])
    }
    store(data: UIImageJPEGRepresentation(image, 0.5), toPath: (firStorageImagesPath + "/" + uuid))
}
func getDataFromPath(path: String, completion: @escaping (Data?) -> Void) {
    let storageRef = Storage.storage().reference()
    if let cachedImage = imageCache.object(forKey: path as NSString) {
        completion(UIImageJPEGRepresentation(cachedImage, 1))
    }
    storageRef.child(path).getData(maxSize: 6 * 1024 * 1024) { (data, error) in
        if let error = error {
            print(error)
        }
        if let data = data {
            let image = UIImage(data: data)
            imageCache.setObject(image!, forKey: path as NSString)
            completion(data)
        } else {
            completion(nil)
        }
    }
}
func stringPrepTime(prepTime: Int) -> String {
    if prepTime%60 == 0 {
        return "\(Int(prepTime/60)) hours"
    } else if prepTime > 60 {
        return "\(Int(prepTime/60)):\(prepTime%60)"
    } else {
        return "\(prepTime)"
    }
}
func store(data: Data?, toPath path: String) {
    let storageRef = Storage.storage().reference()
    storageRef.child(path).putData(data!, metadata: nil) { (metadata, error) in
        if let error = error {
            print(error)
        }
    }
}
func getCoupons(completion: @escaping ([Coupon]?) -> Void) {
    let dbRef = Database.database().reference()
    var couponArray: [Coupon] = []
    dbRef.child(firCouponsNode).observeSingleEvent(of: .value) { (snapshot) in
        if snapshot.exists() {
            if let coupons = snapshot.value as? [String:AnyObject] {
                for key in coupons.keys {
                    if let coupon = coupons[key] as? [String:Any?]{
                        var newCoupon = Coupon()
                        newCoupon.dictToCoupon(dict: coupon, key: key)
                        couponArray.append(newCoupon)
                    }
                    
                }
                completion(couponArray)
            } else {
                completion(nil)
            }
        } else {
            completion(nil)
        }
    }
}
func createCoupon(coupon: Coupon) {
    let dbRef = Database.database().reference()
    dbRef.child(firCouponsNode).childByAutoId().setValue(coupon.couponToDict())
}

func getRestaurants(completion: @escaping ([String]) -> Void) {
    let dbRef = Database.database().reference()
    var restaurantArray: [String] = []
    dbRef.child(firRestaurantsNode).observeSingleEvent(of: .value) { (snapshot) in
        if snapshot.exists() {
            if let restaurants = snapshot.value as? [String:AnyObject] {
                for key in restaurants.keys {
                    restaurantArray.append(key)
                }
                completion(restaurantArray)
            } else {
                completion([""])
            }
        } else {
            completion([""])
        }
    }
}

extension String {
    var numbers: String {
        return String(characters.filter { "0"..."9" ~= $0 })
    }
}
