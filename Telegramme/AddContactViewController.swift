//
//  AddContactViewController.swift
//  Telegramme
//
//  Created by MAD2_P02 on 6/11/19.
//  Copyright © 2019 MAD2_P02. All rights reserved.
//

import UIKit

class AddContactViewController : UIViewController{
    
    @IBOutlet weak var firstNameFld: UITextField!
    @IBOutlet weak var lastNamefLD: UITextField!    
    @IBOutlet weak var mobileFld: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func cancelBtn(_ sender: Any) {
        firstNameFld.text = ""
        lastNamefLD.text = ""
        mobileFld.text = ""
    }
    
    @IBAction func createBtn(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        print(String(appDelegate.contactList.count))
    }
}
