//
//  ViewController.swift
//  CoreDataTest
//
//  Created by Alex Mejicanos on 3/04/17.
//  Copyright © 2017 Alex Mejicanos. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var tableInfo: UITableView?
    
    var persons: [NSManagedObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableInfo?.dataSource = self
        tableInfo?.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        self.load()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return persons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! PersonCell
        
        let person = persons[indexPath.row]
        
        cell.firstName?.text = person.value(forKey: "firstname") as? String
        cell.lastname?.text = person.value(forKey: "lastname") as? String
        cell.username?.text = person.value(forKey: "username") as? String
        cell.sex?.text = (person.value(forKey: "sex") as? Int16) == 0 ? "Male" : "Female"
        
        cell.backgroundColor = (person.value(forKey: "sex") as? Int16) == 0 ? UIColor.cyan : UIColor.green
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "NewUser") as! NewUserViewController
        vc.isNew = false
        vc.person = persons[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            let appDelegate = UIApplication.shared.delegate as? AppDelegate
            
            let manageContext = appDelegate?.persistentContainer.viewContext
            
            do {
                manageContext?.delete(self.persons[indexPath.row])
                try manageContext?.save()
                self.persons.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            } catch let error as NSError {
                print("No se obtener la información: \(error), \(error.userInfo)")
            }
        }
    }
    
    @IBAction func addUser(sender: UIBarButtonItem) -> Void {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "NewUser") as! NewUserViewController
        vc.isNew = true
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func load() -> Void {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        let manageContext = appDelegate?.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Person")
        
        do {
            self.persons = try manageContext?.fetch(fetchRequest) as! [NSManagedObject]
            tableInfo?.reloadData()
        } catch let error as NSError {
            print("No se obtener la información: \(error), \(error.userInfo)")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

