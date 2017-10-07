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
        self.mytable.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.fetchData()
        self.mytable.reloadData()
    }
    
    @IBAction func Back_btnClicked(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func fetchData(){
        
        let appDeleg:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context:NSManagedObjectContext = appDeleg.managedObjectContext
        
        do{
            let request = NSFetchRequest(entityName: "UserInfo")
            let results = try context.executeFetchRequest(request)
            for item in results as! [NSManagedObject]{
                self.userarr.append(item)
            }
            
        }catch{
            print("error in fetching data")
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.userarr.count
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            let appDeleg:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            let context:NSManagedObjectContext = appDeleg.managedObjectContext
            context.deleteObject(self.userarr[indexPath.row])
            do{
                try context.save()
                self.userarr.removeAll()
                self.fetchData()
                self.mytable.reloadData()
            }catch{print("ERROR in Deleting")}
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        let firstname = self.userarr[indexPath.row].valueForKey("firstName") as! String
        let lastname  = self.userarr[indexPath.row].valueForKey("lastName") as! String
        cell.textLabel?.text = firstname + "  " + lastname
        return cell
    }
}
