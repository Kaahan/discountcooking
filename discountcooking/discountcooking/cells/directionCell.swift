//
//  directionCell.swift
//  discountcooking
//
//  Created by Kaahan Radia on 11/4/17.
//  Copyright © 2017 Kaahan Radia. All rights reserved.
//

import Foundation
import UIKit

class directionCell: UITableViewCell {
    
    
    @IBOutlet weak var number: UILabel!
    
    @IBOutlet weak var direction: UILabel!
    
    var item: [String]? {
        didSet {
            number.text = item![0]
            direction.text = item![1]
        }
    }
    static var nib:UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    static var identifier: String {
        return String(describing: self)
    }
}
