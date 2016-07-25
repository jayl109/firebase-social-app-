//
//  ViewController.swift
//  firebase username test
//
//  Created by Jason Lum on 7/23/16.
//  Copyright © 2016 Jason Lum. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseStorage

class ViewController: UIViewController {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var hobbies: UITextField!
    
    
    @IBAction func unwindToMainMenu(sender: UIStoryboardSegue)
    {
    }
    @IBAction func saveButtonClicked(sender: UIStoryboardSegue)
    {
        //extraneous but too lazy to change on main storyboard
    }

    var database=FIRDatabaseReference.init()
    var userprofileref=FIRDatabaseReference.init()
    let userDefaults = NSUserDefaults.standardUserDefaults()
    //let storageref=FIRStorageReference.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        database = FIRDatabase.database().reference()
        //let storageRef = FIRStorage.storage().reference()

        updateprofile()
        //userprofileref.updateChildValues(["test": "test"]) FOR REFERENCE
        userprofileref.observeSingleEventOfType(.Value, withBlock: { (snapshot) in
            self.name.text=snapshot.value!["name"] as! String
            self.address.text=snapshot.value!["address"] as! String
            self.hobbies.text=snapshot.value!["hobbies"] as! String
        })
        /*
        let query=(database.child("profiles").queryOrderedByChild("name").queryEqualToValue("testin"))
        query.observeSingleEventOfType(.Value, withBlock: {(snapshot) in
            print(snapshot.value)
            })
        
 */
        //move the above code to the updateprofile when done

       //let key = database.childByAutoId().key
      // let stuff = ["Name": "Success"]
       //self.database.child(key).setValue(stuff)
        
        
        
        }
    

    func updateprofile(){
        if let name = userDefaults.objectForKey("name"){
            self.name.text=name as! String
        }

        if let address = userDefaults.objectForKey("address"){
                self.address.text=address as! String
        }
        if let hobbies = userDefaults.objectForKey("hobbies"){
            self.hobbies.text=hobbies as! String
        }
        if let image=userDefaults.objectForKey("hobbies")
        {
            self.image.image=image as? UIImage
        }
        else
        {
            self.image.image=UIImage(named: "defaultimage")
        }
        if userDefaults.objectForKey("userkey") == nil
        {
            let key = database.child("profiles").childByAutoId().key
            userDefaults.setValue(key, forKey: "userkey")
            print(String(key))
            userprofileref=database.child("profiles").child(userDefaults.objectForKey("userkey") as! String)
            userprofileref.setValue(["name": "Enter a name", "address": "Enter an address", "hobbies": "None"])
            userDefaults.setObject("Enter a name", forKey: "name")
            userDefaults.setObject("Enter an address", forKey: "address")
            userDefaults.setObject("None", forKey: "hobbies")
            userDefaults.setObject([], forKey: "friends")



            
        }
        userprofileref=database.child("profiles").child(userDefaults.objectForKey("userkey") as! String)
        
    
    }

}


