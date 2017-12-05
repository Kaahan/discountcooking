//
//  CreateRecipeController.swift
//  discountcooking
//
//  Created by Kaahan Radia on 11/24/17.
//  Copyright © 2017 Kaahan Radia. All rights reserved.
//

import Foundation
import UIKit
import Eureka
import ImageRow
import FirebaseDatabase
class CreateRecipeController: FormViewController {
    
    var restaurantCoupons: [Coupon] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        var rules = RuleSet<String>()
        var coupon_names: [String] = []
//        tableView.backgroundColor = UIColor.white
        rules.add(rule: RuleRequired())
        
        getCoupons { (coupons) in
            if let coupon_array = coupons {
                for coupon in coupon_array {
                    if coupon.restaurant == CurrentUser().id {
                        self.restaurantCoupons.append(coupon)
                    }
                }
                for coupon in self.restaurantCoupons {
                    coupon_names.append("Value: $" + String(coupon.value))
                }
                self.form +++ PushRow<String>("Coupon") {
                    $0.title = "Select a Coupon"
                    $0.options = coupon_names
                    $0.value = coupon_names[0]
                    $0.selectorTitle = "Select a Coupon"
                    }.onPresent { from, to in
                        to.dismissOnSelection = false
                        to.dismissOnChange = false
                }
            }
        }
        form +++ Section("Basic information")
            <<< NameRow("Recipe Name") {
                $0.add(ruleSet: rules)
                $0.title = $0.tag
                $0.placeholder = "Recipe Name"
        }
            <<< NameRow("Prep time") {
                $0.title = $0.tag
                $0.placeholder = "In number of minutes"
                $0.validationOptions = .validatesOnChange
                $0.add(ruleSet: rules)
                
        }
            <<< TextAreaRow("Brief Description of Recipe") {
                $0.title = $0.tag
                $0.placeholder = $0.tag
                $0.add(ruleSet: rules)
        }
        form +++ MultivaluedSection(multivaluedOptions: [.Reorder, .Insert, .Delete], header: "Ingredient") {
            $0.tag = "Ingredients"
            $0.addButtonProvider = {section in
                return ButtonRow(){
                    $0.title = "Add New Ingredient"
                    
                    } .cellUpdate({ (cell, row) in
                        cell.textLabel?.textColor = colors["blueberry"]
                    })
            }
            
            $0.multivaluedRowToInsertAt = { index in
                return TextRow() {
                    $0.placeholder = "Ingredient Text"
                    $0.add(ruleSet: rules)
                }
            }
            
            $0 <<< TextRow() {
                $0.placeholder = "Ingredient Text"
            }
            
        }
        form +++ MultivaluedSection(multivaluedOptions: [.Reorder, .Insert, .Delete], header: "Directions") {
            $0.tag = "Directions"
            $0.addButtonProvider = {section in
                return ButtonRow(){
                    $0.title = "Add New Direction"
                    } .cellUpdate({ (cell, row) in
                        cell.textLabel?.textColor = colors["blueberry"]
                    })
            }
            
            $0.multivaluedRowToInsertAt = { index in
                return TextAreaRow() {
                    $0.placeholder = "Direction Text"
                    $0.add(ruleSet: rules)
                }
            }
            
            $0 <<< TextAreaRow() {
                $0.placeholder = "Direction Text"
            }
        }
        form +++ Section("Recipe Image")
            <<< ImageRow() {
                $0.title = "Recipe Image"
                $0.tag = "image"
                $0.add(rule: RuleRequired())
                $0.sourceTypes = [.Camera]
                $0.clearAction = .yes(style: UIAlertActionStyle.destructive)
        }
        .cellUpdate { cell, row in
                    cell.accessoryView?.layer.cornerRadius = 17
                    cell.accessoryView?.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
        }
//        for coupon in restaurantCoupons {
//            coupon_names.append("Value: " + String(coupon.value))
//        }
//        form +++ PushRow<String>() {
//            $0.title = "Select a Coupon"
//            $0.options = coupon_names
//            $0.value = coupon_names[0]
//            $0.selectorTitle = "Select a Coupon"
//            }.onPresent { from, to in
//                to.dismissOnSelection = false
//                to.dismissOnChange = false
//        }

        
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        getCoupons { (coupons) in
//            if let coupon_array = coupons {
//                for coupon in coupon_array {
//                    if coupon.restaurant == CurrentUser().id {
//                        self.restaurantCoupons.append(coupon)
//                    }
//                }
//            }
//        }
    }
    
    @IBAction func saveRecipe(_ sender: UIBarButtonItem) {
        if form.validate().isEmpty {
            let couponValue = (form.rowBy(tag: "Coupon") as! PushRow<String>).value!
            let valuesDictionary = form.values()
            print(valuesDictionary)
            var directionsArray: [String] = []
            if let directions = valuesDictionary["Directions"] {
                for direction in directions as! [String] {
                    directionsArray.append(direction)
                }
            }
            var ingredientArray: [String] = []
            if let ingredients = valuesDictionary["Ingredients"] {
                for ingredient in ingredients as! [String]{
                    ingredientArray.append(ingredient)
                }
            }
            var selectedCoupon: Coupon = Coupon()
            for coupon in restaurantCoupons {
                if coupon.value == Int(couponValue.numbers) {
                    selectedCoupon = coupon
                    break
                }
            }
            let dbRef = Database.database().reference()
            
            var new_recipe = Recipe()
            var dict: [String:Any] = ["name": valuesDictionary["Recipe Name"] as! String, "prepTime": valuesDictionary["Prep time"] as! String, "ingredients": ingredientArray, "directions": directionsArray, "description": valuesDictionary["Brief Description of Recipe"] as! String, "imagePath": "", "coupon": selectedCoupon.couponID, "restaurantID": CurrentUser().id]
            new_recipe.dictToRecipe(dict: dict, key: "")
            var image = (form.rowBy(tag: "image") as! ImageRow).value!
            print(dict)
            createRecipe(recipe: new_recipe, image: image, coupon: selectedCoupon, restaurantID: CurrentUser().id)
            let alertController = UIAlertController(title: "Recipe Created", message: "", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
        } else {
            print("empty")
            
//            new_recipe.dictToRecipe(dict: <#T##[String : Any?]#>, key: "")
            
        }
    }
}

