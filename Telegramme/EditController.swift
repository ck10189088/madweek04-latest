//
//  EditController.swift
//  Telegramme
//
//  Created by MAD2_P02 on 2/12/19.
//  Copyright © 2019 MAD2_P02. All rights reserved.
//

import Foundation
import UIKit

class Editcontroller: UIViewController{
    
    var contactController:ContactController = ContactController()
    var contactList:[Contact]=[]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contactList = contactController.retrieveAllContact()
    }
    var appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var txtlastName: UITextField!
    @IBOutlet weak var txtMobileno: UITextField!
    
    @IBAction func SaveBtn(_ sender: Any) {
        let rowvalue = appDelegate.rowValue
        let contact = contactList[rowvalue!]
        if(txtFirstName.text != nil && txtlastName != nil && txtMobileno != nil){
            contactController.updateContact(mobileno: contact.mobileNo, newContact: Contact(firstname: txtFirstName.text!, lastname: txtlastName.text!, mobileno: txtMobileno.text!))
        }
        if(txtFirstName.text=="" && txtlastName.text=="" && txtMobileno.text == ""){
            let alertView = UIAlertController(title:"failed",message: "failed to update contact", preferredStyle:UIAlertController.Style.alert)
            self.present(alertView,animated: true,completion: nil)
            
            let when = DispatchTime.now()+3
            DispatchQueue.main.asyncAfter(deadline: when){
                alertView.dismiss(animated: true, completion: nil)
            }
        }
        else{
            let alertView = UIAlertController(title: "Success", message: "update contact successfully", preferredStyle: UIAlertController.Style.alert)
            self.present(alertView,animated: true,completion: nil)
        }
        
    }
}
