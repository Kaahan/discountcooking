//
//  IndividualViewModel.swift
//  discountcooking
//
//  Created by Kaahan Radia on 11/3/17.
//  Copyright © 2017 Kaahan Radia. All rights reserved.
//

import Foundation
import UIKit

//Sections: Image, Description, Ingredients, Directions, and Upload

enum RecipeViewModelItemType {
    case image
    case description
    case ingredients
    case directions
    case upload
}

protocol RecipeViewModelItem {
    var type: RecipeViewModelItemType {get}
    var rowCount: Int {get}
    var sectionTitle: String {get}
}
extension RecipeViewModelItem {
    var rowCount: Int {
        return 1
    }
}

class RecipeViewModelImageItem: RecipeViewModelItem {
    
    var sectionTitle: String {
        return ""
    }
    
    var type: RecipeViewModelItemType {
        return .image
    }
    
    var pictureUrl: String
    
    init(pictureUrl: String) {
        self.pictureUrl = pictureUrl
    }
}

class RecipeViewModelDescription: RecipeViewModelItem {
    var sectionTitle: String {
        return "Information"
    }
    var type: RecipeViewModelItemType {
        return .description
    }
    
    var name: String
    var prepTime: Int
    var description: String
    
    init(name: String, prepTime: Int, description: String) {
        self.name = name
        self.prepTime = prepTime
        self.description = description
    }
}

class RecipeViewModelIngredients: RecipeViewModelItem {
    var sectionTitle: String {
        return "Ingredients"
    }
    
    var type: RecipeViewModelItemType {
        return .ingredients
    }
    var rowCount: Int {
        return ingredients.count
    }
    var ingredients: [String]
    
    init(ingredients: [String]) {
        self.ingredients = ingredients
    }
}

class RecipeViewModelDirections: RecipeViewModelItem {
    var sectionTitle: String {
        return "Directions"
    }
    
    var type: RecipeViewModelItemType {
        return .directions
    }
    var rowCount: Int {
        return directions.count
    }
    var directions: [String]
    
    init(directions: [String]) {
        self.directions = directions
    }
}

class RecipeViewModel: NSObject {
    var items = [RecipeViewModelItem]()
    
    override init() {
        super.init()
        
    }
    func updateModel(recipe: Recipe) {
        let description = RecipeViewModelDescription(name: recipe.name, prepTime: recipe.prepTime!, description: recipe.description)
        items.append(description)
        let ingredients = RecipeViewModelIngredients(ingredients: recipe.ingredients)
        items.append(ingredients)
        let directions = RecipeViewModelDirections(directions: recipe.directions)
        items.append(directions)
    }
    func clearModel() {
        items = []
    }
}

extension RecipeViewModel: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.section]
        switch item.type {
        case .description:
            if let cell = tableView.dequeueReusableCell(withIdentifier: descriptionCell.identifier, for: indexPath) as? descriptionCell{
                cell.item = item
                return cell
            }
        case .directions:
            
            if let item = item as? RecipeViewModelDirections, let cell = tableView.dequeueReusableCell(withIdentifier: directionCell.identifier, for: indexPath) as? directionCell {
                cell.item = [String(indexPath.row + 1), item.directions[indexPath.row]]
                return cell
            }
        case .ingredients:
            
            if let item = item as? RecipeViewModelIngredients, let cell = tableView.dequeueReusableCell(withIdentifier: ingredientsCell.identifier, for: indexPath) as? ingredientsCell {
                cell.item = item.ingredients[indexPath.row]
                return cell
            }
        case .image:
            print("wat")
        case .upload:
            print("wat")
        }
        return UITableViewCell()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return items.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items[section].rowCount
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return items[section].sectionTitle
    }
}
