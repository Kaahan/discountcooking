//
//  IndividualRecipeController.swift
//  discountcooking
//
//  Created by Kaahan Radia on 11/3/17.
//  Copyright © 2017 Kaahan Radia. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase
import FirebaseStorage

class IndividualRecipeController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    
    
    
    
    
    @IBOutlet weak var individualTableView: UITableView!
    fileprivate let recipeViewModel = RecipeViewModel()
    var recipe: Recipe = Recipe()
    var picker: UIImagePickerController? = UIImagePickerController()
    var image: UIImage?
    var uploadDidVerify: Bool = false
    var path: String = ""
    weak var timer: Timer?
    override func viewDidLoad() {
        super.viewDidLoad()
        recipeViewModel.updateModel(recipe: self.recipe)
        individualTableView.dataSource = recipeViewModel
        
        individualTableView.estimatedRowHeight = 100
        individualTableView.rowHeight = UITableViewAutomaticDimension
        
        individualTableView.register(imageCell.nib, forCellReuseIdentifier: imageCell.identifier)
        individualTableView.register(descriptionCell.nib, forCellReuseIdentifier: descriptionCell.identifier)
        individualTableView.register(ingredientsCell.nib, forCellReuseIdentifier: ingredientsCell.identifier)
        individualTableView.register(directionCell.nib, forCellReuseIdentifier: directionCell.identifier)
        individualTableView.register(uploadCell.nib, forCellReuseIdentifier: uploadCell.identifier)
        picker!.delegate = self
    }
    override func viewDidDisappear(_ animated: Bool) {
        stopTimer()
    }
    override func viewWillAppear(_ animated: Bool) {
        //recipeViewModel.clearModel()
        startTimer()
        recipeViewModel.buttonWasTapped = false
        uploadDidVerify = false
        path = ""
    }
    //Aite, so basically this is some super jank code that uses a timer to check when the upload button is clicked, bc we can't call a segue from the extension or custom tableviewcell, sorry in advance
    
    func startTimer() {
        timer?.invalidate()   // just in case you had existing `Timer`, `invalidate` it before we lose our reference to it
        print("started timer")
        timer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true) { [weak self] _ in
            if (self?.recipeViewModel.buttonWasTapped)! {
                print("button has been tapped")
                self?.openCamera()
                self?.stopTimer()
            } else {
                print ("button was not yet tapped")
            }
        }
    }
    
    func stopTimer() {
        print ("stopped timer")
        timer?.invalidate()
    }
    func openCamera() {
        if (UIImagePickerController .isSourceTypeAvailable(UIImagePickerControllerSourceType .camera)) {
            picker!.sourceType = UIImagePickerControllerSourceType.camera
            self.present(picker!, animated: true, completion: nil)
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]){
        print("this triggered")
        image = info[UIImagePickerControllerOriginalImage] as? UIImage
        let uuid = NSUUID().uuidString
        //Going to have restaurant manually verify through qr code stuff
        path = firStorageUserImagesPath + "/" + CurrentUser().id + "/" + uuid
        if let picture = image {
            store(data: UIImageJPEGRepresentation(picture, 0.5), toPath: path)
            
        }
        
        uploadDidVerify = true
        performSegue(withIdentifier: "unwindToRecipeController", sender: uploadDidVerify)
        picker .dismiss(animated: true, completion: nil)
        
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController){
        picker .dismiss(animated: true, completion: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? RecipeController {
            if let uploadDidVerify = sender as? Bool{
                dest.individualDidReturn = uploadDidVerify
                dest.doneRecipe = recipe
                dest.imagePath = path
            }
        }
    }
}
