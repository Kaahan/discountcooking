//
//  RestaurantLoginController.swift
//  discountcooking
//
//  Created by Kaahan Radia on 11/19/17.
//  Copyright © 2017 Kaahan Radia. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth

class RestaurantLoginController: UIViewController, UITextFieldDelegate {
    
    
    
    @IBOutlet weak var passwordTextField: KaedeTextField!
    @IBOutlet weak var emailTextField: KaedeTextField!
    var userEmail = ""
    var userPassword = ""
    var handle: AuthStateDidChangeListenerHandle?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.emailTextField.delegate = self
        self.passwordTextField.delegate = self
        let tap = UITapGestureRecognizer(target: self.view, action: Selector("endEditing:"))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
        self.view.backgroundColor = colors["light-grey"]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            // ...
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        Auth.auth().removeStateDidChangeListener(handle!)
    }
    @IBAction func unwindToLogin(segue:UIStoryboardSegue) {
        
    }
    @IBAction func restaurantLogin(_ sender: Any) {
        guard let emailText = emailTextField.text else {return}
        guard let passwordText = passwordTextField.text else {
            return
        }
        
        if emailText == "" || passwordText == "" {
            let alertController = UIAlertController(title: "Log In Error", message: "Please enter an email and password.", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
        }
        else {
            if (emailText != "" && passwordText != "nil") {
                Auth.auth().signIn(withEmail: emailText, password: passwordText) { (user, error) in
                    if let error = error{
                        let alertController = UIAlertController(title: "Log In Error", message: error.localizedDescription, preferredStyle: .alert)
                        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                        alertController.addAction(defaultAction)
                        self.present(alertController, animated: true, completion: nil)
                        return
                    } else {
                        var isRestaurant: Bool = false
                        var restaurant_id: String = ""
                        getRestaurants(completion: { (restaurantIDs) in
                            for id in restaurantIDs {
                                
                                if isRestaurant == false {
                                    if id == CurrentUser().id {
                                        isRestaurant = true
                                        restaurant_id = id
                                    } else {
                                        isRestaurant = false
                                    }
                                } else {
                                    
                                }
                                
                            }
                            if isRestaurant == true {
                                getRestaurant(id: restaurant_id, completion: { (restaurant) in
                                    if restaurant?.verified == true {
                                        self.loginSuccessful()
                                    } else {
                                        let alertController = UIAlertController(title: "Log In Error", message: "This restaurant is not verfied yet", preferredStyle: .alert)
                                        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                                        alertController.addAction(defaultAction)
                                        self.present(alertController, animated: true, completion: nil)
                                    }
                                })
                            } else {
                                let alertController = UIAlertController(title: "Log In Error", message: "This email is not associated with a restaurant", preferredStyle: .alert)
                                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                                alertController.addAction(defaultAction)
                                self.present(alertController, animated: true, completion: nil)
                                
                            }
                        })
                        
//                        CurrentUser().getRole(completion: { (role) in
//                            if (role != "restaurant") {
//                                let alertController = UIAlertController(title: "Log In Error", message: "You are not marked as a restaurant user", preferredStyle: .alert)
//                                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
//                                alertController.addAction(defaultAction)
//                                self.present(alertController, animated: true, completion: nil)
//                                return false
//                            }
//                            else {
//                                self.loginSuccessful()
//                                return true
//                            }
//                        })
                        
                        
                        
                    }
                }
                
            }
            
        }
        
    }
    func loginSuccessful() {
        performSegue(withIdentifier: "restaurantLoginToMain", sender: self)
    }
    @IBAction func signUpPressed(_ sender: Any) {
        performSegue(withIdentifier: "restaurantLoginToSignUp", sender: self)
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == self.emailTextField {
            if textField.text != nil {
                self.userEmail = textField.text!
            }
        } else {
            if textField.text != nil {
                self.userPassword = textField.text!
            }
        }
    }
}
