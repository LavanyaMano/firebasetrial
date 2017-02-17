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
    var  sweets = [Sweet]()

    override func viewDidLoad() {
        super.viewDidLoad()
        dbRef = FIRDatabase.database().reference().child("sweet-items")
        startObservingDB()
            }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        FIRAuth.auth()?.addStateDidChangeListener({ (FIRAuth, FIRUser) in
            if let user = FIRUser{
                print("Welcome \( user.email)")
                self.startObservingDB()
            } else{
                print("You need to signup to login first")
            }
        })
    }
    @IBAction func loginandsignup(_ sender: Any) {
        let userAlert = UIAlertController(title: "login/signup", message: "Enter Email and password", preferredStyle:.alert)
        userAlert.addTextField(configurationHandler: {(textField:UITextField)in
        textField.placeholder = "Email"
        })
        
        userAlert.addTextField(configurationHandler: {
            (textField:UITextField) in
            textField.isSecureTextEntry = true
            textField.placeholder = "Password"
        })
        userAlert.addAction(UIAlertAction(title: "Sign in",
                                      style: UIAlertActionStyle.default,
                                      handler: {(alert: UIAlertAction!) in
            let emailTextField = userAlert.textFields!.first!
            let passwordTextField = userAlert.textFields!.last!
                                        
                                        FIRAuth.auth()?.signIn(withEmail: emailTextField.text!, password: passwordTextField.text!, completion: {
                                            (user:FIRUser?, Error) in
                                            if Error != nil {
                                                print(Error!.localizedDescription)
                                            }
                                        })
        }))
        userAlert.addAction(UIAlertAction(title: "Sign up",
                                          style: UIAlertActionStyle.default,
                                          handler: {(alert: UIAlertAction!) in
            let emailTextField = userAlert.textFields!.first!
            let passwordTextField = userAlert.textFields!.last!
                                            
            FIRAuth.auth()?.createUser(withEmail: emailTextField.text!, password: passwordTextField.text!, completion: {(user:FIRUser?, Error) in
                if Error != nil {
                                                    print(Error!.localizedDescription)
                                                }
                                            })
        }))
        self.present(userAlert, animated: true, completion: nil)
    }

    func startObservingDB(){
        dbRef.observe(.value, with: {(snapshot: FIRDataSnapshot) in
            var newSweets = [Sweet]()
            
            for sweet in snapshot.children {
                let sweetObject = Sweet(snapshot: sweet as! FIRDataSnapshot)
                newSweets.append(sweetObject)
            }
            self.sweets = newSweets
            self.tableView.reloadData()
        }
    )
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
        return sweets.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let sweet = sweets[indexPath.row]
            cell.textLabel?.text = sweet.content
            cell.detailTextLabel?.text = sweet.addedbyUser
        return cell
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            let sweet = sweets[indexPath.row]
            sweet.itemRef?.removeValue()
        }
    }
}
