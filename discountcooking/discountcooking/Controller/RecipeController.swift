//
//  RecipeController.swift
//  discountcooking
//
//  Created by Kaahan Radia on 10/16/17.
//  Copyright © 2017 Kaahan Radia. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase
class RecipeController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    func uploadDidVerify(completion: @escaping (String) -> Void) {
        if individualDidReturn! {
            if individualDidReturn == true{
                let dbRef = Database.database().reference()
                var userID: String = ""
                completion(currentUser.id)
                
                let alertController = UIAlertController(title: "Great Cooking!", message: "A coupon should have been added to your inventory", preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)
                
            } else {
                completion("")
            }
            
            
        } else {
//            let alertController = UIAlertController(title: "Something went wrong!", message: "Either your image wasn't particularly close to the recipe description, or something went wrong on our end.", preferredStyle: .alert)
//            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
//            alertController.addAction(defaultAction)
//            self.present(alertController, animated: true, completion: nil)
            completion("")
        }
    }
    
    
    
    @IBOutlet weak var recipeTable: UITableView!
    
    let currentUser = CurrentUser()
    var recipeArray: [Recipe] = []
    var individualDidReturn: Bool? = false
    var doneRecipe: Recipe = Recipe()
    var imagePath: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        recipeTable.dataSource = self
        recipeTable.delegate = self
        recipeTable.backgroundColor = colors["light-grey"]
    }
    override func viewWillAppear(_ animated: Bool) {
        if individualDidReturn == true {
            let dbRef = Database.database().reference()
            var userID: String = ""
            let user = dbRef.child(firUsersNode).child(currentUser.id)
            var newDoneRecipes: [String:String] = [:]
            self.currentUser.getDoneRecipes(completion: { (doneRecipes) in
                newDoneRecipes = doneRecipes
                newDoneRecipes[self.doneRecipe.recipeID!] = self.imagePath
                user.updateChildValues(["doneRecipes" : newDoneRecipes])
                self.currentUser.getCoupons(completion: { (coupons) in
                    var newCoupons = coupons
                    newCoupons[(self.doneRecipe.coupon)] = self.doneRecipe.recipeID
                    user.updateChildValues(["coupons" : newCoupons])
                    self.doneRecipe = Recipe()
                    self.individualDidReturn = false
                    self.imagePath = ""
                    self.updateData()
                    self.recipeTable.reloadData()
                })
                
                
                
            })
            let alertController = UIAlertController(title: "Great Cooking!", message: "A coupon should have been added to your inventory", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
            
        } else {
            self.updateData()
            self.recipeTable.reloadData()
        }
        
//        self.uploadDidVerify(completion: { (key) in
//            if key == "" {
//                self.updateData()
//                self.recipeTable.reloadData()
//            } else {
//                let dbRef = Database.database().reference()
//                let user = dbRef.child(firUsersNode).child(key)
//                var newDoneRecipes: [String:String] = [:]
//                self.currentUser.getDoneRecipes(completion: { (doneRecipes) in
//                    newDoneRecipes = doneRecipes
//
//
//                })
//                newDoneRecipes[self.doneRecipe.recipeID!] = self.imagePath
//                user.updateChildValues(["doneRecipes" : newDoneRecipes])
//                self.doneRecipe = Recipe()
//                self.individualDidReturn = false
//                self.imagePath = ""
//
//
//            }
//
//        })
        
    }
    @IBAction func unwindToRecipeController(segue: UIStoryboardSegue) {
        
    }
    func updateData() {
        getRecipes(user: currentUser) { (recipes, key) in
            self.clearRecipes()
            if let recipes = recipes {
                for recipe in recipes {
                    self.recipeArray.append(recipe)
                }
                self.recipeTable.reloadData()
            }
        }
        
    }
    func clearRecipes() {
        recipeArray = []
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var number = recipeArray.count
        if number != 0 {
            tableView.separatorStyle = .singleLine
            tableView.backgroundView = nil
        } else {
            
            let noDataLabel: UILabel     = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
            noDataLabel.text          = "You've finished all the recipes we have for now, check back later!"
            noDataLabel.textColor     = colors["blueberry"]
            noDataLabel.textAlignment = .center
            noDataLabel.font = UIFont(name: "Gravity-Light", size: 17)
            noDataLabel.numberOfLines = 0
            tableView.backgroundView  = noDataLabel
            tableView.separatorStyle  = .none
            
        }
        return number
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = recipeTable.dequeueReusableCell(withIdentifier: "recipeCell", for: indexPath) as! recipeControllerCell
        let recipe = recipeArray[indexPath.row]
        cell.recipeCellName.text = recipe.name
        cell.recipeShortDescription.text = recipe.description
        getRestaurant(id: recipe.restaurantID) { (restaurant) in
            cell.recipeCellRestaurantName.text = restaurant!.name
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toIndividualRecipe", sender: recipeArray[indexPath.row])
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.clear
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? IndividualRecipeController {
            if let recipe = sender as? Recipe {
                dest.recipe = recipe
            }
        }
    }
}
