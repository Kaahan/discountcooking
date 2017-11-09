//
//  IndividualRecipeController.swift
//  discountcooking
//
//  Created by Kaahan Radia on 11/3/17.
//  Copyright © 2017 Kaahan Radia. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase
import FirebaseStorage

class IndividualRecipeController: UIViewController {
    
    @IBOutlet weak var individualTableView: UITableView!
    fileprivate let recipeViewModel = RecipeViewModel()
    var recipe: Recipe = Recipe()
    override func viewDidLoad() {
        super.viewDidLoad()
        recipeViewModel.updateModel(recipe: self.recipe)
        individualTableView.dataSource = recipeViewModel
        
        individualTableView.estimatedRowHeight = 100
        individualTableView.rowHeight = UITableViewAutomaticDimension
        
        individualTableView.register(imageCell.nib, forCellReuseIdentifier: imageCell.identifier)
        individualTableView.register(descriptionCell.nib, forCellReuseIdentifier: descriptionCell.identifier)
        individualTableView.register(ingredientsCell.nib, forCellReuseIdentifier: ingredientsCell.identifier)
        individualTableView.register(directionCell.nib, forCellReuseIdentifier: directionCell.identifier)
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        //recipeViewModel.clearModel()
    }
}
