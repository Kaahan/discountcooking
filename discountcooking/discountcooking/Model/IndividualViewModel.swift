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
        return ""
    }
    var type: RecipeViewModelItemType {
        return .description
    }
    var rowCount: Int {
        return 1
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
class RecipeViewModelUpload: RecipeViewModelItem {
    var sectionTitle: String {
        return ""
    }
    var type: RecipeViewModelItemType {
        return .upload
    }
    init() {
        
    }
}
class RecipeViewModel: NSObject {
    
    var items = [RecipeViewModelItem]()
    var buttonWasTapped = false
    
    override init() {
        super.init()
        
    }
    func updateModel(recipe: Recipe) {
        let image = RecipeViewModelImageItem(pictureUrl: recipe.imagePath)
        items.append(image)
        let description = RecipeViewModelDescription(name: recipe.name, prepTime: recipe.prepTime, description: recipe.description)
        items.append(description)
        let ingredients = RecipeViewModelIngredients(ingredients: recipe.ingredients)
        items.append(ingredients)
        let directions = RecipeViewModelDirections(directions: recipe.directions)
        items.append(directions)
        let upload = RecipeViewModelUpload()
        items.append(upload)
    }
    func clearModel() {
        items = []
    }
}

extension RecipeViewModel: UITableViewDataSource {
    
    @objc func buttonTapped(_ sender:UIButton!){
        buttonWasTapped = true
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.section]
        switch item.type {
        case .description:
            if let item = item as? RecipeViewModelDescription, let cell = tableView.dequeueReusableCell(withIdentifier: descriptionCell.identifier, for: indexPath) as? descriptionCell{
                cell.item = [item.name, "\(item.prepTime)", item.description]
                cell.isUserInteractionEnabled = false
                return cell
            }
        case .directions:
            
            if let item = item as? RecipeViewModelDirections, let cell = tableView.dequeueReusableCell(withIdentifier: directionCell.identifier, for: indexPath) as? directionCell {
                cell.item = [String(indexPath.row + 1), item.directions[indexPath.row]]
                cell.isUserInteractionEnabled = false
                return cell
            }
        case .ingredients:
            
            if let item = item as? RecipeViewModelIngredients, let cell = tableView.dequeueReusableCell(withIdentifier: ingredientsCell.identifier, for: indexPath) as? ingredientsCell {
                cell.item = item.ingredients[indexPath.row]
                cell.isUserInteractionEnabled = false
                cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
                return cell
            }
        case .image:
            if let item = item as? RecipeViewModelImageItem, let cell = tableView.dequeueReusableCell(withIdentifier: imageCell.identifier, for: indexPath) as? imageCell {
                cell.item = item.pictureUrl
                cell.isUserInteractionEnabled = false
                return cell
            }
        case .upload:
            if let cell = tableView.dequeueReusableCell(withIdentifier: uploadCell.identifier, for: indexPath) as? uploadCell {
                cell.uploadButton.tag = indexPath.row
                cell.uploadButton.addTarget(self, action: #selector(RecipeViewModel.buttonTapped), for: UIControlEvents.touchUpInside)
                return cell
            }
            
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


