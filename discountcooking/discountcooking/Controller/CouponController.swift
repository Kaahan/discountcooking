//
//  CouponController.swift
//  discountcooking
//
//  Created by Kaahan Radia on 11/19/17.
//  Copyright © 2017 Kaahan Radia. All rights reserved.
//

import Foundation
import UIKit

class CouponController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var currentUser = CurrentUser()
    var userCoupons: [Coupon] = []
    var returnedCoupons: [String:String] = [:]
    @IBOutlet weak var couponTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        couponTableView.delegate = self
        couponTableView.dataSource = self
        couponTableView.backgroundColor = colors["light-grey"]
        
    }
    override func viewWillAppear(_ animated: Bool) {
        clearCoupons()
        currentUser.getCoupons { (coupons) in
            self.returnedCoupons = coupons
            getCoupons { (returnedcoupons) in
                if let coupons = returnedcoupons {
                    for coupon in coupons {
                        if self.returnedCoupons[coupon.couponID] != nil {
                            self.userCoupons.append(coupon)
                        } else {
                            print("user doesn't have this coupon")
                        }
                        
                    }
                    self.couponTableView.reloadData()
                    self.returnedCoupons = [:]
                } else {
                    
                }
            }
        }
        
    }
    
    func clearCoupons() {
        userCoupons = []
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var number = userCoupons.count
        if number != 0 {
            tableView.separatorStyle = .singleLine
            tableView.backgroundView = nil
        } else {
            
            let noDataLabel: UILabel     = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
            noDataLabel.text          = "You don't have any coupons :("
            noDataLabel.textColor     = colors["blueberry"]
            noDataLabel.textAlignment = .center
            noDataLabel.font = UIFont(name: "Gravity-Light", size: 17)
            tableView.backgroundView  = noDataLabel
            tableView.separatorStyle  = .none
            
        }
        return number
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "couponCell", for: indexPath) as! couponControllerCell
        let coupon = userCoupons[indexPath.row]
        cell.couponName.text = "$\(coupon.value) off"
        getRestaurant(id: coupon.restaurant) { (restaurant) in
            cell.restaurantName.text = restaurant!.name
        }
        print("made cell")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toIndividualCoupon", sender: userCoupons[indexPath.row])
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.clear
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? IndividualCouponController {
            if let coupon = sender as? Coupon {
                dest.coupon = coupon
            }
        }
    }
    
    
}
