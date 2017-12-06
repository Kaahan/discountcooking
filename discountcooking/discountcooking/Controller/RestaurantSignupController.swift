//
//  RestaurantSignupController.swift
//  discountcooking
//
//  Created by Kaahan Radia on 11/29/17.
//  Copyright © 2017 Kaahan Radia. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth
import FirebaseDatabase

class RestaurantSignupController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var signupVerifPass: KaedeTextField!
    @IBOutlet weak var signupPass: KaedeTextField!
    @IBOutlet weak var signupEmail: KaedeTextField!
    @IBOutlet weak var signupName: KaedeTextField!
    @IBOutlet weak var signupPhone: KaedeTextField!
    var restaurantEmail = ""
    var restaurantName = ""
    var restaurantPassword = ""
    var restaurantVerifiedPassword = ""
    var restaurantPhone = ""
    var dbRef = Database.database().reference()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.signupVerifPass.delegate = self
        self.signupName.delegate = self
        self.signupPass.delegate = self
        self.signupEmail.delegate = self
        let tap = UITapGestureRecognizer(target: self.view, action: Selector("endEditing:"))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
        self.view.backgroundColor = colors["light-grey"]
    }
    @IBAction func backWasPressed(_ sender: Any) {
        performSegue(withIdentifier: "unwindToRestaurantLogin", sender: nil)
    }
    @IBAction func signupWasPressed(_ sender: Any) {
        guard let email = signupEmail.text else { return }
        guard let password = signupPass.text else { return }
        guard let name = signupName.text else { return }
        guard let verifiedPassword = signupVerifPass.text else { return }
        guard let phone = signupPhone.text else {return}
        if email == "" || password == "" || name == "" || verifiedPassword == "" || phone == "" {
            let alertController = UIAlertController(title: "Form Error.", message: "Please fill in form completely.", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            present(alertController, animated: true, completion: nil)
            
        } else if password != verifiedPassword {
            let alertController = UIAlertController(title: "Verification Error.", message: "The two passwords do not match.", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
        }
        else {
            Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
                if let error = error {
                    let alertController = UIAlertController(title: "Sign Up Error", message: error.localizedDescription, preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    self.present(alertController, animated: true, completion: nil)
                    
                } else {
                    let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                    changeRequest?.displayName = name
                    changeRequest?.commitChanges { (error) in
                        if let _ = error {
                            print("error occured in changing name")
                        }
                    }
                    
                    let alertController = UIAlertController(title: "Account will be verified by Discount Cooking before you can log in", message: "", preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: {action in self.performSegue(withIdentifier: "unwindToLogin", sender: Auth.auth().currentUser)})
                    alertController.addAction(defaultAction)
                    self.present(alertController, animated: true, completion: nil)
                    
                }
                let user = Auth.auth().currentUser
                let uid: String = (user!.uid)
                let dict: [String:Any?] = ["name": name, "coupons": ["empty"], "recipes": ["empty"], "verified": false, "phone": phone]
                self.dbRef.child(firRestaurantsNode).child(uid).setValue(dict)
                
            }
            
            
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == self.signupEmail {
            if textField.text != nil {
                self.restaurantEmail = textField.text!
            }
        } else if textField == self.signupPass {
            if textField.text != nil {
                self.restaurantPassword = textField.text!
            }
        } else if textField == self.signupName {
            if textField.text != nil {
                self.restaurantName = textField.text!
            }
        } else if textField == self.signupVerifPass {
            if textField.text != nil {
                self.restaurantVerifiedPassword = textField.text!
            }
        } else if textField == self.signupPhone {
            if textField.text != nil {
                self.restaurantPhone = textField.text!
            }
        }
    }
    
}
