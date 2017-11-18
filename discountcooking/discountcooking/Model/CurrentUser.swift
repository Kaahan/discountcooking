//
//  CurrentUser.swift
//  discountcooking
//
//  Created by Kaahan Radia on 10/25/17.
//  Copyright © 2017 Kaahan Radia. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth


class CurrentUser {
    
    var username: String!
    var id: String!
    
    let dbRef = Database.database().reference()
    
    init() {
        let currentUser = Auth.auth().currentUser
        username = currentUser?.displayName
        id = currentUser?.uid
        
    }
    
    //Get ID's of done recipes in a string array
    func getDoneRecipes(completion: @escaping ([String:String]) -> Void) {
        //var doneRecipes: [String] = []
//            getUserByID(id: self.id) { (key) in
//                self.dbRef.child(firUsersNode).child(key).child(firDoneRecipesNode).observeSingleEvent(of: .value, with: { (snapshot) in
//                    if snapshot.exists() {
//                        if let returnedDoneRecipes = snapshot.value as? [String:String] {
//                            completion(returnedDoneRecipes)
//                        } else {
//                            completion(["":""])
//                        }
//                    } else {
//                        completion(["":""])
//                    }
//                })
//            }
        self.dbRef.child(firUsersNode).child(id).child(firDoneRecipesNode).observeSingleEvent(of: .value, with: { (snapshot) in
            if snapshot.exists() {
                if let returnedDoneRecipes = snapshot.value as? [String:String] {
                    completion(returnedDoneRecipes)
                } else {
                    completion(["":""])
                }
            } else {
                completion(["":""])
            }
        })
}
        
        

    
    func getCoupons(completion: @escaping ([String]) -> Void) {
        var userCoupons: [String] = []
        
        dbRef.child(firUsersNode).child(id).child(firUserCouponsNode).observeSingleEvent(of: .value, with: { (snapshot) in
            if snapshot.exists() {
                let values = snapshot.value as! [String:AnyObject]
                for key in values.keys {
                    userCoupons.append(values[key] as! String)
                }
                completion(userCoupons)
            } else {
                completion([""])
            }
        })
    }
    
    
}
