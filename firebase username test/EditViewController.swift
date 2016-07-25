//
//  EditViewController.swift
//  firebase username test
//
//  Created by Jason Lum on 7/23/16.
//  Copyright © 2016 Jason Lum. All rights reserved.
//

import UIKit

import Firebase

class EditViewController: UIViewController {
    let userDefaults = NSUserDefaults.standardUserDefaults()
    
    var database=FIRDatabaseReference.init()
    var userprofileref=FIRDatabaseReference.init()
    //var usersref=FIRDatabaseReference.init()
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var hobbies: UITextField!
    @IBOutlet weak var addfriend: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        database = FIRDatabase.database().reference()
        userprofileref = FIRDatabase.database().reference().child("profiles").child(userDefaults.objectForKey("userkey") as! String)
         //usersref = FIRDatabase.database().reference().child("Users")
        userprofileref.observeSingleEventOfType(.Value, withBlock: { (snapshot) in
            self.name.text=snapshot.value!["name"] as! String
            self.address.text=snapshot.value!["address"] as! String
            self.hobbies.text=snapshot.value!["hobbies"] as! String
        })
    }
    func checkfriend(name: String)
    {
        
    }
    //code to save profile info
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "SaveProfile" {
            userprofileref.updateChildValues(["name": name.text!, "address": address.text!, "hobbies": hobbies.text!])
            
            //usersref.child(userDefaults.objectForKey("name") as! String).removeValue()
            //usersref.child(name.text!).updateChildValues(["key": userDefaults.objectForKey("userkey") as! String])
            userDefaults.setObject(name.text!, forKey: "name")
            userDefaults.setObject(address.text!, forKey: "address")
            userDefaults.setObject(hobbies.text!, forKey: "hobbies")
            addfriends()
            
                
            }

        }
        //checks if friend's name is in database, adds it to friends list if it is
        func addfriends()
        {
            if addfriend.text != nil && addfriend.text != ""{
                let query=(database.child("profiles").queryOrderedByChild("name").queryEqualToValue(addfriend.text!))
                query.observeSingleEventOfType(.Value, withBlock: {(snapshot) in
                    if snapshot.value != nil
                    {
                        let json=snapshot.value as? [String: AnyObject]
                        // for some reason a if let statement didnt work here, dont know why
                        if json != nil{
                        
                        let friendname = Array(json!.keys)[0]
                        print (friendname)
                        self.userprofileref.child("friends").updateChildValues([friendname: "True"])
                        }
                        
                        
                                      }
                })
                
                
                
            }

    }
    }






