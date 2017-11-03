//
//  Coupon.swift
//  discountcooking
//
//  Created by Kaahan Radia on 10/17/17.
//  Copyright © 2017 Kaahan Radia. All rights reserved.
//

import Foundation

class Coupon {
    
    var value: Int
    var percent: Float
    var recipes: [Recipe]
    var couponID: String
    
    init(id: String, value: Int = 0, percent: Float = 0.0, recipes: [Recipe]) {
        self.value = value
        self.percent = percent
        self.recipes = recipes
        self.couponID = id
    }
    //TODO: QRCode function
    func generateQR() {
        
    }
    //TODO: Verify valid
    func verify() {
        
    }
}
