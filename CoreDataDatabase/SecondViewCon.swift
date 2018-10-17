//
//  SecondViewCon.swift
//  CoreDataDatabase
//
//  Created by Mostafa on 7/14/17.
//  Copyright © 2017 Mostafa. All rights reserved.
//

import UIKit
import CoreData

class SecondViewCon: UIViewController , UITableViewDataSource , UITableViewDelegate {
    
    @IBOutlet weak var mytable: UITableView!
    var userarr:[NSManagedObject] = []
    
    override func viewDidLoad() {
        self.mytable.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.fetchData()
        self.mytable.reloadData()
    }
    
    @IBAction func Back_btnClicked(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func fetchData(){
        
        let appDeleg:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let context:NSManagedObjectContext = appDeleg.managedObjectContext
        
        do{
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "UserInfo")
            let results = try context.fetch(request)
            for item in results as! [NSManagedObject]{
                self.userarr.append(item)
            }
            
        }catch{
            print("error in fetching data")
        }
    }
    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.userarr.count
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            let appDeleg:AppDelegate = UIApplication.shared.delegate as! AppDelegate
            let context:NSManagedObjectContext = appDeleg.managedObjectContext
            context.delete(self.userarr[indexPath.row])
            do{
                try context.save()
                self.userarr.removeAll()
                self.fetchData()
                self.mytable.reloadData()
            }catch{print("ERROR in Deleting")}
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let firstname = self.userarr[indexPath.row].value(forKey: "firstName") as! String
        let lastname  = self.userarr[indexPath.row].value(forKey: "lastName") as! String
        cell.textLabel?.text = firstname + "  " + lastname
        return cell
    }
}
