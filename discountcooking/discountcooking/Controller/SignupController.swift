//
//  SignupController.swift
//  discountcooking
//
//  Created by Kaahan Radia on 10/16/17.
//  Copyright © 2017 Kaahan Radia. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth
import FirebaseDatabase
class SignupController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var signupVerifPass: KaedeTextField!
    @IBOutlet weak var signupPass: KaedeTextField!
    @IBOutlet weak var signupEmail: KaedeTextField!
    @IBOutlet weak var signupName: KaedeTextField!
    
    var userEmail = ""
    var userName = ""
    var userPassword = ""
    var userVerifiedPassWord = ""
    var dbRef = Database.database().reference()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.signupVerifPass.delegate = self
        self.signupName.delegate = self
        self.signupPass.delegate = self
        self.signupEmail.delegate = self
    }
    @IBAction func signupWasPressed(_ sender: Any) {
        guard let email = signupEmail.text else { return }
        guard let password = signupPass.text else { return }
        guard let name = signupName.text else { return }
        guard let verifiedPassword = signupVerifPass.text else { return }
        if email == "" || password == "" || name == "" || verifiedPassword == "" {
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
                   
                    let alertController = UIAlertController(title: "Account created!", message: "", preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: {action in self.performSegue(withIdentifier: signupToMain, sender: Auth.auth().currentUser)})
                    alertController.addAction(defaultAction)
                    self.present(alertController, animated: true, completion: nil)
                    
                }
                let uid: String = (Auth.auth().currentUser?.uid)!
                let dict: [String:Any?] = ["uid": uid, "coupons": ["empty"], "recipes": ["empty"]]
                self.dbRef.child("Users").childByAutoId().setValue(dict)
                
            }
        
            
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == self.signupEmail {
            if textField.text != nil {
                self.userEmail = textField.text!
            }
        } else if textField == self.signupPass {
            if textField.text != nil {
                self.userPassword = textField.text!
            }
        } else if textField == self.signupName {
            if textField.text != nil {
                self.userName = textField.text!
            }
        } else if textField == self.signupVerifPass {
            if textField.text != nil {
                self.userVerifiedPassWord = textField.text!
            }
        }
    }
}
