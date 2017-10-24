//
//  Restaurant.swift
//  discountcooking
//
//  Created by Kaahan Radia on 10/17/17.
//  Copyright © 2017 Kaahan Radia. All rights reserved.
//

import Foundation

class Restaurant {
    internal var name: String
    internal var coupons: [Coupon]
    internal var recipes: [Recipe]
    init(name: String, coupons: [Coupon], recipes: [Recipe]) {
        self.name = name
        self.coupons = coupons
        self.recipes = recipes
    }
    func getName() -> String {
        return self.name
    }
    func getCoupons() -> [Coupon] {
        return self.coupons
    }
    func getRecipes() -> [Recipe] {
        return self.recipes
    }
}
