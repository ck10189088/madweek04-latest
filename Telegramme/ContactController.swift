//
//  ContactController.swift
//  Telegramme
//
//  Created by MAD2_P02 on 18/11/19.
//  Copyright © 2019 MAD2_P02. All rights reserved.
//
import UIKit
import CoreData

class ContactController {
    
    func AddContact(newContact:Contact){
        let appDelegate = (UIApplication.shared.delegate) as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "CDContact", in: context)!
        
        let CDContact = NSManagedObject(entity: entity, insertInto: context)
        CDContact.setValue("Yong Lun", forKey: "firstname")
        CDContact.setValue("Wong", forKey: "lastname")
        CDContact.setValue("11223344", forKey: "mobileno")
        
        do{
            try context.save()
        }catch let error as NSError{
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func retrieveAllContact()->[Contact]{
        var contact:[NSManagedObject]=[]
        
        let appDelegate = (UIApplication.shared.delegate) as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "CDContact")
        do{
            contact = try context.fetch(fetchRequest)
            
            for c in contact{
                let firstname = c.value(forKeyPath: "firstname") as? String
                let lastname = c.value(forKeyPath: "lastname") as? String
                let mobileno = c.value(forKeyPath: "mobileno") as? String
                print("\(firstname) \(lastname), \(mobileno!)")
            }
            
        }catch let error as NSError{
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return contact
    }
}
