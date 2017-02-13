//
//  SweetsTableViewController.swift
//  Trial
//
//  Created by lava m on 2/13/17.
//  Copyright © 2017 Firebase. All rights reserved.
//

import UIKit

class SweetsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

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
