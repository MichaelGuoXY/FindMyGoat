//
//  DetailsViewController.swift
//  FindMyGoat
//
//  Created by Guo Xiaoyu on 3/5/16.
//  Copyright © 2016 Xiaoyu Guo. All rights reserved.
//

import UIKit
import RealmSwift

class DetailsViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var goat : Goat!
    var chosenImage : UIImage!
    var nameValid = true
    var ageValid = true
    
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBAction func cancelButtonClicked(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func chooseImageBtnClicked(sender: UIButton) {
        let alertController = UIAlertController(title: "Choose an image for your data?", message: "Select a way", preferredStyle: .ActionSheet)
        let takeNewPhotoAction = UIAlertAction(title: "Take a new photo", style: .Default, handler: { action in
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.allowsEditing = true
            picker.sourceType = .Camera
            self.presentViewController(picker, animated: true, completion: nil)
        })
        let chooseFromLib = UIAlertAction(title: "Choose from my photos", style: .Default, handler: { action in
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.allowsEditing = true
            picker.sourceType = .PhotoLibrary
            self.presentViewController(picker, animated: true, completion: nil)
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        alertController.addAction(takeNewPhotoAction)
        alertController.addAction(chooseFromLib)
        alertController.addAction(cancelAction)
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        chosenImage = info[UIImagePickerControllerEditedImage] as! UIImage
        imageView.image = chosenImage
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func saveButtonClicked(sender: UIButton) {
        
        //let goat = Goat()
        
        
        let realm = try! Realm()
        try! realm.write {
            goat.name = nameTextField.text!
            goat.age = Int(ageTextField.text!)!
            goat.imgData = UIImageJPEGRepresentation(imageView.image!, 0.5);
            realm.add(goat)
        }
        
        let nGoats = realm.objects(Goat).count
        print("We have \(nGoats) goats in the database")
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    @IBAction func addButtonClicked(sender: UIButton) {
        let newGoat = Goat()
        let realm = try! Realm()
        try! realm.write {
            newGoat.name = nameTextField.text!
            newGoat.age = Int(ageTextField.text!)!
            newGoat.imgData = UIImageJPEGRepresentation(imageView.image!, 0.5);
            realm.add(newGoat)
        }
        
        let nGoats = realm.objects(Goat).count
        print("We have \(nGoats) goats in the database")
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.nameTextField.text = goat.name
        self.ageTextField.text = "\(goat.age)"
        if goat.imgData != nil {
            self.imageView.image = UIImage.init(data: goat.imgData)
        }
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func nameTextFieldEditingDidChanged(sender: UITextField) {
        if(sender.text != "") {
            nameValid = true
        }
        else {
            nameValid = false
        }
        
        addButton.enabled = nameValid && ageValid
        saveButton.enabled = nameValid && ageValid
    }
    @IBAction func ageTextFieldEditingDidChanged(sender: UITextField) {
        let age:Int? = Int(sender.text!)
        print(age)
        if (age != nil) {
            ageValid = true
        }
        else {
            ageValid = false
        }
        
        addButton.enabled = nameValid && ageValid
        saveButton.enabled = nameValid && ageValid
    }
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.ageTextField.resignFirstResponder()
        self.nameTextField.resignFirstResponder()
    }
}
