//
//  VerifyQRController.swift
//  discountcooking
//
//  Created by Kaahan Radia on 11/19/17.
//  Copyright © 2017 Kaahan Radia. All rights reserved.
//

import Foundation
import UIKit
import QRCodeReader
import AVFoundation
import FirebaseDatabase
class VerifyQRController: UIViewController, QRCodeReaderViewControllerDelegate  {
    
    @IBOutlet weak var recipeNameLabel: UILabel!
    @IBOutlet weak var resultImageView: UIImageView!
    var recipeName: String = ""
    var uid: String = ""
    var couponID: String = ""
    
    @IBOutlet weak var declineButton: UIButton!
    @IBOutlet weak var acceptButton: UIButton!
    lazy var readerVC: QRCodeReaderViewController = {
        let builder = QRCodeReaderViewControllerBuilder {
            $0.reader = QRCodeReader(metadataObjectTypes: [.qr], captureDevicePosition: .back)
        }
        
        return QRCodeReaderViewController(builder: builder)
    }()
    
    @IBAction func scanQRCode(_ sender: Any) {
        readerVC.delegate = self
        
        readerVC.modalPresentationStyle = .formSheet
        present(readerVC, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = colors["light-grey"]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        clear()
    }
    func clear() {
        resultImageView.image = UIImage()
        acceptButton.isHidden = true
        declineButton.isHidden = true
        recipeNameLabel.isHidden = true
    }
    @IBAction func declineClick(_ sender: Any) {
        print("memes")
        let dbRef = Database.database().reference()
        dbRef.child(firUsersNode).child(uid).child(firUserCouponsNode).child(couponID).removeValue()
        clear()
    }
    @IBAction func acceptClick(_ sender: Any) {
        print("ayylmao")
        let dbRef = Database.database().reference()
        dbRef.child(firUsersNode).child(uid).child(firUserCouponsNode).child(couponID).removeValue()
        clear()
        
        
    }
    func reader(_ reader: QRCodeReaderViewController, didScanResult result: QRCodeReaderResult) {
//        reader.stopScanning()
        
        let information = result.value
        let info_array = information.split(separator: " ")
        let dbRef = Database.database().reference()
        let uid = String(info_array[0])
        let couponID = String(info_array[1])
        var called = false
        dbRef.child(firUsersNode).child(uid).child(firUserCouponsNode).observeSingleEvent(of: .value) { (snapshot) in
            if called {
                
            } else {
                called = true
                print(info_array)
                self.dismiss(animated: true, completion: nil)
                reader.stopScanning()
                if snapshot.exists() {
                    if let coupons = snapshot.value as? [String:AnyObject?] {
                        for couponkey in coupons.keys {
                            if couponkey == couponID {
                                dbRef.child(firUsersNode).child(uid).child(firDoneRecipesNode).observeSingleEvent(of: .value, with: { (snapshot) in
                                    if snapshot.exists() {
                                        if let doneRecipes = snapshot.value as? [String:AnyObject?] {
                                            for recipekey in doneRecipes.keys {
                                                if recipekey == coupons[couponkey] as? String {
                                                    print(doneRecipes[recipekey] as! String)
                                                    getDataFromPath(path: doneRecipes[recipekey] as! String, completion: { (returnedimage) in
                                                        if returnedimage != nil {
                                                            self.resultImageView.image = UIImage(data: returnedimage!)
                                                            self.couponID = couponID
                                                            self.uid = uid
                                                            self.declineButton.isHidden = false
                                                            self.acceptButton.isHidden = false
                                                            
                                                        }
                                                        
                                                    })
                                                    getRecipe(id: recipekey, completion: { (recipe) in
                                                        self.recipeNameLabel.text = recipe!.name
                                                        self.recipeNameLabel.isHidden = false
                                                    })
                                                }
                                            }
                                        }
                                    } else {
                                        
                                    }
                                })
                            }
                        }
                        
                    } else {
                        
                    }
                } else {
                    
                }
            }
            
        }
        
    }
    
    func readerDidCancel(_ reader: QRCodeReaderViewController) {
        reader.stopScanning()
        
        dismiss(animated: true, completion: nil)
    }
    
    
    
    
}
