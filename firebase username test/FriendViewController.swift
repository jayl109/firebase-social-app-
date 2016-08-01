//
//  FriendViewController.swift
//  firebase username test
//
//  Created by Jason Lum on 7/30/16.
//  Copyright © 2016 Jason Lum. All rights reserved.
//

import UIKit
import Firebase

class FriendViewController: UIViewController {
    var friendKey: String?
    var friendname: String?
    var database: FIRDatabaseReference?
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var hobbies: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        name.text=friendname
        print(friendKey!)
        getFriendInfo()
    }
    
    
    func getFriendInfo(){
        database!.child(friendKey!).observeSingleEventOfType(.Value, withBlock: { (snapshot) in
            self.address.text=snapshot.value!["address"] as? String
            self.hobbies.text=snapshot.value!["hobbies"] as? String
        })
    }
    @IBAction func unwindToMainMenu(sender: UIStoryboardSegue){
        print("unwinding")
    }
   

}
