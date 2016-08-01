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
    var database=FIRDatabaseReference.init()
    var friends=[String]()
    var names=[String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        database=FIRDatabase.database().reference().child("profiles")
    friendref=FIRDatabase.database().reference().child("profiles").child(userDefaults.objectForKey("userkey") as! String).child("friends")
        addfriends()
        
    }
    func addfriends(){
        friendref.observeSingleEventOfType(.Value, withBlock: { (snapshot) in
            let json=snapshot.value as? [String: AnyObject]
            print(json)
            if json != nil {
                for x in Array(json!.keys)
                {
                    self.friends.append(x)
                    print(self.friends)
                }
                print("got up to here")
                self.getfriendnames()
            }
        })
        
    }
    func getfriendnames()
    {
        for x in friends
        {
            database.child(x).observeSingleEventOfType(.Value, withBlock: { (snapshot) in
                // Get user value
                let username = snapshot.value!["name"] as? String
                self.names.append(username!)
                print(self.names)
                self.tableView.reloadData()
                // ...
            }) { (error) in
                print(error.localizedDescription)
            }
        }
        
        
        
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
       
        
        print ("success")
        performSegueWithIdentifier("showFriend", sender: self)
        
    }
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
            return names.count
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("profile", forIndexPath: indexPath)
        
        // Configure the cell...
        if names.count > indexPath.section{
        cell.textLabel?.text = names[indexPath.section]
        }
        
        return cell
        
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
        
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destination = segue.destinationViewController as? FriendViewController
        let section = tableView.indexPathForSelectedRow?.section
        destination!.friendKey=friends[section!]
        destination!.friendname=names[section!]
        destination!.database=database
        
    }
}
