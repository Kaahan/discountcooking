//
//  LoginController.swift
//  discountcooking
//
//  Created by Kaahan Radia on 10/15/17.
//  Copyright © 2017 Kaahan Radia. All rights reserved.
//

import Foundation
import UIKit

class InitialController: UIViewController {
    
    @IBOutlet weak var tagline: UILabel!
    @IBOutlet weak var signup: UIButton!
    @IBOutlet weak var login: UIButton!
    @IBOutlet weak var background: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        background.addBlurEffect()
        login.backgroundColor = colors["blueberry"]
        signup.backgroundColor = colors["citrus"]
        let text = "where cooking meets saving"
        let textwithcolor1 = "saving"
        let textwithcolor2 = "cooking"
        let range = (text as NSString).range(of: textwithcolor1)
        let range2 = (text as NSString).range(of: textwithcolor2)
        let attributedString = NSMutableAttributedString(string:text)
        attributedString.addAttribute(NSAttributedStringKey.foregroundColor, value: colors["apricot"]! , range: range)
        attributedString.addAttribute(NSAttributedStringKey.foregroundColor, value: colors["citrus"]! , range: range2)
        tagline.attributedText = attributedString

    }
    
    @IBAction func login(_ sender: Any) {
        performSegue(withIdentifier: "toLogin", sender: nil)
        
    }
    
    @IBAction func signup(_ sender: Any) {
        performSegue(withIdentifier: "toSignup", sender: nil)
    }
    
    @IBAction func unwindToInitial(segue: UIStoryboardSegue) {
        
    }
}
