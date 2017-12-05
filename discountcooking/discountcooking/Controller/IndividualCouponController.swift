//
//  IndividualCouponController.swift
//  discountcooking
//
//  Created by Kaahan Radia on 11/19/17.
//  Copyright © 2017 Kaahan Radia. All rights reserved.
//

import Foundation
import UIKit

class IndividualCouponController: UIViewController {
    
    var coupon: Coupon = Coupon()
    
    @IBOutlet weak var qrImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        qrImageView.image = coupon.generateQR(user: CurrentUser(), coupon: coupon)
        
    }
    
    
}
