//
//  ShowContactViewController.swift
//  Telegramme
//
//  Created by MAD2_P02 on 25/11/19.
//  Copyright © 2019 MAD2_P02. All rights reserved.
//

import UIKit
 // these are the code for sth like recycleview in java
class ShowContactViewController:UITableViewController{
    
    var contactList:[Contact] = []
    var appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let contactController = ContactController()
        contactList = contactController.retrieveAllContact()
        self.tableView.reloadData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView : UITableView, numberOfRowsInSection section:Int) -> Int {
        return contactList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)->UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "ContactCell", for: indexPath)
        
        let contact = contactList[indexPath.row]
        cell.textLabel!.text = "\(contact.firstName) \(contact.lastName)"
        cell.detailTextLabel!.text = "\(contact.mobileNo)"
        return cell
    }
    
}
