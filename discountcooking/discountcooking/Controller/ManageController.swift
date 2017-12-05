//
//  ManageController.swift
//  discountcooking
//
//  Created by Kaahan Radia on 11/24/17.
//  Copyright © 2017 Kaahan Radia. All rights reserved.
//

import Foundation
import UIKit
import Eureka

class ManageController: UIViewController {
    //Gate creating recipe by if they have >= 1 coupon
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = colors["light-grey"]
        
    }
    @IBAction func unwindToManage(segue: UIStoryboardSegue) {
        
    }
    @IBAction func newRecipe(_ sender: Any) {
        
        performSegue(withIdentifier: "toCreateRecipe", sender: nil)
    }
    @IBAction func newCoupon(_ sender: Any) {
        performSegue(withIdentifier: "toCreateCoupon", sender: nil)
    }
}
