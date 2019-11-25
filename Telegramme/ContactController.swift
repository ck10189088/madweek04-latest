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
        CDContact.setValue(newContact.firstName, forKey: "firstname")
        CDContact.setValue(newContact.lastName, forKey: "lastname")
        CDContact.setValue(newContact.mobileNo, forKey: "mobileno")
        
        do{
            try context.save()
        }catch let error as NSError{
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func retrieveAllContact()->[Contact]{
        var contact:[NSManagedObject]=[]
        var contactList:[Contact] = []
        
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
                contactList.append(Contact(firstname: "\(firstname)", lastname: "\(lastname)", mobileno: "\(mobileno)")) //difference between firstname and "\(firstname)"? why cannot just firstname
            }
            
        }catch let error as NSError{
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return contactList
    }
    
    func updateContact(mobileno:String,newContact: Contact){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CDContact")
        fetchRequest.predicate = NSPredicate(format: "lastName = %@", "Doe-2")
        
        do{
            let result = try managedContext.fetch(fetchRequest)
            let obj = result[0] as! NSManagedObject
            
            obj.setValue("New John", forKeyPath: "firstName")
            obj.setValue("Doe", forKeyPath: "lastName")
            obj.setValue("New Mobile", forKeyPath: "mobile")
            
            do{
                try managedContext.save()
            } catch let error as NSError{
            print("update error: \(error), \(error.userInfo)")
            }
        }
        catch{
            print("error")
        }
    }
    
    func deleteContact(mobileno:String){
        
    }
}
