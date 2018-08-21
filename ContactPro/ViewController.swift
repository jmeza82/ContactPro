//
//  ViewController.swift
//  ContactPro
//
//  Created by Juan Meza on 1/3/18.
//  Copyright © 2018 Tech-IN. All rights reserved.
//

import UIKit

var contactsArray = [Contact]()

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var contactImgView: UIImageView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let unarchivedData = UserDefaults.standard.object(forKey: "contact") as? Data
        
        if let unarchivedData = unarchivedData {
            
            contactsArray = NSKeyedUnarchiver.unarchiveObject(with: unarchivedData) as! [Contact]
            
            print(contactsArray)
            if contactsArray.count > 0 {
                let singleContact = contactsArray[0]
                nameLabel.text = singleContact.name
                phoneLabel.text = singleContact.phone
                
                let imagepath = imagePath(imageName: singleContact.imageName)
                let image = UIImage(contentsOfFile: imagepath.path)
                
                contactImgView.image = image
            }
            
            collectionView.reloadData()
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self 
        rounded(view: contactImgView, radius: 110)
        
       
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return contactsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "contactCell", for: indexPath)
        
        let imgView = cell.viewWithTag(10) as! UIImageView
        
        let contact = contactsArray[indexPath.row]
        let imageName = contact.imageName
        
        let imagepath = imagePath(imageName: imageName)
        let image = UIImage(contentsOfFile: imagepath.path)
        
        imgView.image = image
        rounded(view: imgView, radius: 50)
        imgView.layer.borderColor = UIColor.white.cgColor
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let contact = contactsArray[indexPath.row]
        let imageName = contact.imageName
        let phone = contact.phone
        let name = contact.name
        
        let imagepath = imagePath(imageName: imageName)
        let image = UIImage(contentsOfFile: imagepath.path)
        
        nameLabel.text = name.uppercased()
        phoneLabel.text = phone
        contactImgView.image = image
        
    }
    func imagePath(imageName: String) -> URL {
        
        let urlPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        //print(urlPath)
        let directory = urlPath[0]
        let imagePath = directory.appendingPathComponent(imageName)
        
        return imagePath
        
    }

    func rounded(view: UIView, radius: CGFloat){
        
        view.layer.cornerRadius = radius
        view.layer.borderColor = UIColor(red:0.27, green:0.69, blue:0.60, alpha:1.00).cgColor
        view.layer.borderWidth = 3
        view.clipsToBounds = true
    }


}

