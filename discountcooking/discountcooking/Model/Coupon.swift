//
//  Coupon.swift
//  discountcooking
//
//  Created by Kaahan Radia on 10/17/17.
//  Copyright © 2017 Kaahan Radia. All rights reserved.
//

import Foundation
import QRCode

class Coupon {
    
    var value: Int = 0
    var percent: Float = 0.0
    var recipes: [String] = []
    var couponID: String = ""
    var restaurant: String = ""
    init() {

    }
    
    func dictToCoupon(dict: [String:Any?], key: String) {
        self.value = Int(dict["value"] as! String)!
        self.percent = Float(dict["percent"] as! String)!
        self.recipes = dict["recipes"] as! [String]
        self.couponID = key
        self.restaurant = dict["restaurant"] as! String
    }
    
    func couponToDict() -> [String:Any?] {
        return ["value": String(self.value), "percent": String(self.percent), "recipes": self.recipes, "restaurant": self.restaurant]
    }
    
    //TODO: QRCode function
    func generateQR(user: CurrentUser, coupon: Coupon) -> UIImage {
        var user_id = ""
        if let uid = user.id {
            user_id = uid
        }
        let datastring: String = "\(user_id) \(coupon.couponID) \(coupon.value) "
        let qrCode = QRCode(datastring.data(using: String.Encoding.utf8)!)
        return qrCode.image!
    }
    
}
