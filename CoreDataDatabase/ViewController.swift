//
//  ViewController.swift
//  CoreDataDatabase
//
//  Created by Mostafa on 7/14/17.
//  Copyright © 2017 Mostafa. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var firstName:  UITextField!
    @IBOutlet weak var secondName: UITextField!
    @IBOutlet weak var searchName: UITextField!
    @IBOutlet weak var searchResult: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func Save_btnClicked(sender: UIButton) {
        
        let appDeleg:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context:NSManagedObjectContext = appDeleg.managedObjectContext
        let newUser = NSEntityDescription.insertNewObjectForEntityForName("UserInfo", inManagedObjectContext: context)
        newUser.setValue(self.firstName.text, forKey: "firstName")
        newUser.setValue(self.secondName.text, forKey: "lastName")
        do{
            try context.save()
        }catch{
            print("error in saving data")
        }
    }
    
    @IBAction func Search_btnClicked(sender: UIButton) {
        let appDeleg:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context:NSManagedObjectContext = appDeleg.managedObjectContext
        let request = NSFetchRequest(entityName: "UserInfo")
        let searchString = self.searchName.text!
        request.predicate = NSPredicate(format:"firstName == '\(searchString)'")
        do{
            let results = try context.executeFetchRequest(request)
            if results.count > 0 {
                let first = results[0].valueForKey("firstName") as! String
                let last = results[0].valueForKey("lastName")  as! String
                searchResult.text = first + " " + last
            }else{
                searchResult.text = "No Result Found"
            }
            
        }catch{
            print("error in fetching data")
        }

    }
    
    @IBAction func Show_btnClicked(sender: UIButton) {
        
        let mainStoryboard = UIStoryboard(name: "Main", bundle:NSBundle.mainBundle())
        let secdViewCon:SecondViewCon  = mainStoryboard.instantiateViewControllerWithIdentifier("secondViewCon") as!SecondViewCon
        self.presentViewController(secdViewCon, animated: true, completion: nil)
        
    }
    
}

