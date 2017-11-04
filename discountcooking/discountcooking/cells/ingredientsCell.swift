//
//  ingredientsCell.swift
//  discountcooking
//
//  Created by Kaahan Radia on 11/4/17.
//  Copyright © 2017 Kaahan Radia. All rights reserved.
//

import Foundation
import UIKit

class ingredientsCell: UITableViewCell {
    
    
    @IBOutlet weak var ingredientIngredient: UILabel!
    
    var item: String? {
        didSet{
            ingredientIngredient.text = item!
        }
    }
    
    static var nib:UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    static var identifier: String {
        return String(describing: self)
    }
}
