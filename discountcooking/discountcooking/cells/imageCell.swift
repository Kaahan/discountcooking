//
//  imageCell.swift
//  discountcooking
//
//  Created by Kaahan Radia on 11/8/17.
//  Copyright © 2017 Kaahan Radia. All rights reserved.
//

import Foundation
import UIKit

class imageCell: UITableViewCell {
    
    @IBOutlet weak var imageCellImage: UIImageView!
    var item: String? {
        didSet {
            getDataFromPath(path: item!) { (data) in
                if let data = data {
                    let image = UIImage(data: data)
                    self.imageCellImage.image = image
                }
            }
        }
    }
    static var nib:UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    static var identifier: String {
        return String(describing: self)
    }
 }
