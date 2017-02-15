//
//  SweetsTableViewController.swift
//  Trial
//
//  Created by lava m on 2/13/17.
//  Copyright © 2017 Firebase. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class SweetsTableViewController: UITableViewController {
    
    var dbRef:FIRDatabaseReference!

    override func viewDidLoad() {
        super.viewDidLoad()
        dbRef = FIRDatabase.database().reference().child("sweet-items")
    }

    @IBAction func addSweet(_ sender: Any) {
        let sweetAlert = UIAlertController(title:"NewSweet",message:"Enter your sweet", preferredStyle:.alert)
        
        sweetAlert.addTextField(configurationHandler: {(textField:UITextField) in
            textField.placeholder =  "Your Sweet"
        })
        
        sweetAlert.addAction(UIAlertAction(title:"send",style:.default,handler:{(action:UIAlertAction)in
            if let sweetContent = sweetAlert.textFields?.first?.text {
                let sweet = Sweet(content: sweetContent, addedbyUser: "lava")
                
                let sweetRef = self.dbRef.child(sweetContent.lowercased())
                
                sweetRef.setValue(sweet.toAnyObject())
            }
        }))
        
        self.present(sweetAlert, animated: true, completion: nil)
    }
   
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

   // Configure the cell...

        return cell
    }

}
