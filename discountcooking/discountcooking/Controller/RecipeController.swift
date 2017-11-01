//
//  RecipeController.swift
//  discountcooking
//
//  Created by Kaahan Radia on 10/16/17.
//  Copyright © 2017 Kaahan Radia. All rights reserved.
//

import Foundation
import UIKit

class RecipeController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var recipeTable: UITableView!
 
    let currentUser = CurrentUser()
    var recipeArray: [Recipe] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recipeTable.dataSource = self
        recipeTable.delegate = self
    }
    override func viewWillAppear(_ animated: Bool) {
        recipeTable.reloadData()
        self.updateData()
        
    }
    func updateData() {
        getRecipes(user: currentUser) { (recipes) in
            self.clearRecipes()
            if let recipes = recipes {
                for recipe in recipes {
                    if recipe.done != true {
                        self.recipeArray.append(recipe)
                    }
                }
                self.recipeTable.reloadData()
            }
        }
        
    }
    func clearRecipes() {
        recipeArray = []
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipeArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = recipeTable.dequeueReusableCell(withIdentifier: "recipeCell", for: indexPath) as! recipeControllerCell
        let recipe = recipeArray[indexPath.row]
        cell.recipeCellName.text = recipe.name
        cell.recipeShortDescription.text = recipe.description
        getRestaurantName(id: recipe.restaurantID) { (name) in
            cell.recipeCellRestaurantName.text = name
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("clicked")
    }
    
}
