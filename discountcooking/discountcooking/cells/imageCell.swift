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
            DispatchQueue.global(qos: .userInitiated).async {
                var imageData: Data = Data()
                getDataFromPath(path: self.item!) { (returnData) in
                    if let data = returnData {
                        imageData = data
                    }
                }
                // Bounce back to the main thread to update the UI
                DispatchQueue.main.async {
                    let image = UIImage(data: imageData)
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
