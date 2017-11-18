//
//  uploadCell.swift
//  discountcooking
//
//  Created by Kaahan Radia on 11/11/17.
//  Copyright © 2017 Kaahan Radia. All rights reserved.
//

import Foundation
import UIKit

class uploadCell: UITableViewCell {
    @IBOutlet weak var uploadButton: UIButton!
    static var nib:UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    static var identifier: String {
        return String(describing: self)
    }
    
    
    @IBAction func uploadTapped(_ sender: Any) {
        
    }
}

