//
//  AddContactViewController.swift
//  ContactPro
//
//  Created by Juan Meza on 1/4/18.
//  Copyright © 2018 Tech-IN. All rights reserved.
//

import UIKit

class AddContactViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBOutlet weak var contactImgView: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameTextField.delegate = self
        phoneTextField.delegate = self
        
        nameTextField.becomeFirstResponder()
        
        rounded(view: nameTextField, radius: 5)
        rounded(view: phoneTextField, radius: 5)
        rounded(view: contactImgView, radius: 50)
    }
    
    func rounded(view: UIView, radius: CGFloat) {
        
        view.layer.cornerRadius = radius
        view.layer.borderColor = UIColor(red: 0.27, green:0.69, blue:0.60, alpha:1.0).cgColor
        view.layer.borderWidth = 3
        view.clipsToBounds = true
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        nameTextField.resignFirstResponder()
        phoneTextField.resignFirstResponder()
        
        return true
    
    }
    
    @IBAction func selectPhoto(_ sender: Any) {
        
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        picker.sourceType = .photoLibrary
        
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let image = info[UIImagePickerControllerEditedImage]
        contactImgView.image = image as! UIImage
        
        dismiss(animated: true)
    }
    @IBAction func save(_ sender: Any) {
        
        if (nameTextField.text?.isEmpty)! || (phoneTextField.text?.isEmpty)! || (contactImgView.image == nil) {
            
            let alert = UIAlertController(title: "All required", message: "Please provide a name, phone number and a photo  in order  to continue", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(ok)
            
            present(alert, animated: true)
            return
        }
        
        let name = nameTextField.text!
        let phone = phoneTextField.text!
        let imageName = name.removeSpaces()
        let randomInt = arc4random_uniform(1000)
        let finalImageName = "\(imageName)\(randomInt)"
        
        let newContact = Contact(name: name, phone: phone, imageName: finalImageName)
        contactsArray.insert(newContact, at: 0)
        
        print(contactsArray)
        let archivedData = NSKeyedArchiver.archivedData(withRootObject: contactsArray)
        UserDefaults.standard.set(archivedData, forKey: "contact")
        //print(finalImageName)
        
        let image = contactImgView.image!
        if let jpgImage = UIImageJPEGRepresentation(image, 0.8) {
            let urlPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
            //print(urlPath)
            let directory = urlPath[0]
            let imagePath = directory.appendingPathComponent(finalImageName)
            
            try? jpgImage.write(to: imagePath)
        }
    }
    
}
