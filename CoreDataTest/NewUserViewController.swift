//
//  NewUserViewController.swift
//  CoreDataTest
//
//  Created by Alex Mejicanos on 3/04/17.
//  Copyright © 2017 Alex Mejicanos. All rights reserved.
//

import UIKit
import CoreData

class NewUserViewController: UIViewController {

    @IBOutlet var firstName: UITextField?
    @IBOutlet var lastName: UITextField?
    @IBOutlet var username: UITextField?
    @IBOutlet var sex: UISegmentedControl?
    
    var person: NSManagedObject?
    var isNew: Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(NewUserViewController.dismissKeyboard))
        
        view.addGestureRecognizer(tap)
        
        if isNew == false {
            firstName?.text = person?.value(forKey: "firstname") as! String
            lastName?.text = person?.value(forKey: "lastname") as! String
            username?.text = person?.value(forKey: "username") as! String
            sex?.selectedSegmentIndex = person?.value(forKey: "sex") as! Int
        }
    }

    @IBAction func savePerson(sender: UIButton) -> Void {
        
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        let manageContext = appDelegate?.persistentContainer.viewContext
       
        if isNew! {
            let entity = NSEntityDescription.entity(forEntityName: "Person", in: manageContext!)
            
            let newPerson = NSManagedObject(entity: entity!, insertInto: manageContext)
            
            newPerson.setValue(firstName?.text, forKey: "firstname")
            newPerson.setValue(lastName?.text, forKey: "lastname")
            newPerson.setValue(username?.text, forKey: "username")
            newPerson.setValue(sex?.selectedSegmentIndex, forKey: "sex")
        } else {
            person?.setValue(firstName?.text, forKey: "firstname")
            person?.setValue(lastName?.text, forKey: "lastname")
            person?.setValue(username?.text, forKey: "username")
            person?.setValue(sex?.selectedSegmentIndex, forKey: "sex")
            
        }
        
        do {
            try manageContext?.save()
            self.navigationController?.popViewController(animated: true)
        } catch let error as NSError {
            print("No se pudo guardar: \(error), \(error.userInfo)")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Calls this function when the tap is recognized.
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
