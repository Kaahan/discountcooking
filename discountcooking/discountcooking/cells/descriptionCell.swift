//
//  descriptionCell.swift
//  discountcooking
//
//  Created by Kaahan Radia on 11/4/17.
//  Copyright © 2017 Kaahan Radia. All rights reserved.
//

import Foundation
import UIKit

class descriptionCell: UITableViewCell {
    
    
    @IBOutlet weak var descriptionName: UILabel!
    @IBOutlet weak var descriptionDescription: UILabel!
    @IBOutlet weak var descriptionTime: UILabel!
    
    var item: [String]? {
        didSet {
            descriptionName.text = item![0]
            descriptionTime.text = item![1]
            descriptionDescription.text = item![2]
            
        }
    }
    
    static var nib:UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
}
