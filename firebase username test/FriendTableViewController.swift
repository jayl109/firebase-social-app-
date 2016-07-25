//
//  FriendTableViewController.swift
//  firebase username test
//
//  Created by Jason Lum on 7/24/16.
//  Copyright © 2016 Jason Lum. All rights reserved.
//

import UIKit
import Firebase
class FriendTableViewController: UITableViewController {
    let userDefaults = NSUserDefaults.standardUserDefaults()
    var friendref=FIRDatabaseReference.init()
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    
        var numberoffriends=0
        friendref=FIRDatabase.database().reference().child("profiles").child(userDefaults.objectForKey("userkey") as! String).child("friends")
        friendref.observeSingleEventOfType(.Value, withBlock: { (snapshot) in
            //for _ in snapshot.value! as! Dictionary{
           //     numberoffriends = numberoffriends+1
            //}
            print (snapshot.value!)
            numberoffriends++
            
            
        })
        print (numberoffriends)
        return numberoffriends
    }

}
