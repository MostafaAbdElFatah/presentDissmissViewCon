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

    @IBAction func Save_btnClicked(_ sender: UIButton) {
        
        let appDeleg:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let context:NSManagedObjectContext = appDeleg.managedObjectContext
        let entity = NSEntityDescription.entity(forEntityName: "UserInfo", in: context)
        let newUser = NSManagedObject(entity: entity!, insertInto: context)
        newUser.setValue(self.firstName.text, forKey: "firstName")
        newUser.setValue(self.secondName.text, forKey: "lastName")
        do{
            try context.save()
        }catch{
            print("error in saving data")
        }
    }
    
    @IBAction func Search_btnClicked(_ sender: UIButton) {
        let appDeleg:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let context:NSManagedObjectContext = appDeleg.managedObjectContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "UserInfo")
        let searchString = self.searchName.text!
        request.predicate = NSPredicate(format:"firstName == '\(searchString)'")
        do{
            let results = try context.fetch(request) as! [NSManagedObject]
            if results.count > 0 {
                let first = results[0].value(forKey: "firstName") as! String
                let last = results[0].value(forKey: "lastName")  as! String
                searchResult.text = first + " " + last
            }else{
                searchResult.text = "No Result Found"
            }
            
        }catch{
            print("error in fetching data")
        }

    }
    
    @IBAction func Show_btnClicked(_ sender: UIButton) {
        
        let mainStoryboard = UIStoryboard(name: "Main", bundle:Bundle.main)
        let secdViewCon:SecondViewCon  = mainStoryboard.instantiateViewController(withIdentifier: "secondViewCon") as!SecondViewCon
        self.present(secdViewCon, animated: true)
        
    }
    
}

