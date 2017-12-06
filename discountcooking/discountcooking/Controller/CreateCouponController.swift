//
//  CreateCouponController.swift
//  discountcooking
//
//  Created by Kaahan Radia on 11/24/17.
//  Copyright © 2017 Kaahan Radia. All rights reserved.
//

import Foundation
import UIKit
import Eureka

class CreateCouponController: FormViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        form +++ Section()
            <<< IntRow() {
                $0.tag = "value"
                $0.placeholder = "Enter $ value of coupon"
                $0.add(rule: RuleRequired())
        }
        
    }
    @IBAction func saveCoupon(_ sender: Any) {
        if form.validate().isEmpty {
            let valuesDictionary = form.values()
            let coupon_value = (form.rowBy(tag: "value") as! IntRow).value!
            var string_coupon_value = String(describing: coupon_value)
            
            let dict: [String:Any] = ["value": string_coupon_value, "percent": "0.0", "recipes": ["empty"], "restaurant": CurrentUser().id]
            var new_coupon = Coupon()
            new_coupon.dictToCoupon(dict: dict, key: "")
            createCoupon(coupon: new_coupon)
        } else {
            
        }
    }
}
