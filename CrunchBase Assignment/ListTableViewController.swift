//
//  ListTableViewController.swift
//  CrunchBase Assignment
//
//  Created by Diwakar Kamboj on 01/11/15.
//  Copyright © 2015 Nagarro. All rights reserved.
//

import UIKit
import Alamofire

class ListTableViewController: UITableViewController {

    @IBOutlet weak var loadActivityIndicator: UIActivityIndicatorView!
    
    var queryType = ""
    var query = ""
    var numResults = 0
    
    var cellText: [String] = []
//    var cellSub: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        //loadActivityIndicator.center = CGPointMake(UIScreen.mainScreen().bounds.size.width/2,UIScreen.mainScreen().bounds.size.height/2)
        
        
        let url = "https://api.crunchbase.com/v/3/" + queryType
        
        let key = ""
        
        Alamofire.request(.GET, url, parameters: ["name": query, "user_key": key])
            .responseJSON { response in
                //                print(response.request)  // original URL request
                //                print(response.response) // URL response
                //                print(response.data)     // server data
                print("Status: \(response.result)")   // result of response serialization
                
                if (response.result.description == "FAILURE") {
                    
                    self.showAlerts("Error!", alertMessage: "Something went wrong")
                    
                }
                
                else {
                
                let num = response.result.value?.objectForKey("data")?.objectForKey("paging")?.objectForKey("total_items") as? NSNumber
                
                self.numResults = num!.integerValue
                
                    if self.numResults == 0 {
                        self.showAlerts("Oops!", alertMessage: "Your query didn't return any results")
                    }
                    
                    else {
                        if self.numResults > 99 {
                            self.numResults = 100
                        }
                    
                        //print(self.numResults)
                        
                        if self.queryType == "organizations" {
                            for i in 0..<self.numResults {
                                let nameJSON = response.result.value?.objectForKey("data")?.objectForKey("items")?.objectAtIndex(i).objectForKey("properties")?.objectForKey("name")
//                                let roleJSON = response.result.value?.objectForKey("data")?.objectForKey("items")?.objectAtIndex(i).objectForKey("properties")?.objectForKey("primary_role")
                                //print("JSON: \(JSON!)")
                                self.cellText.append(nameJSON as! String)
//                                self.cellSub.append(roleJSON as! String)
                            }
                        }
                        
                        else if self.queryType == "people" {
                            for i in 0..<self.numResults {
                                let firstNameJSON = response.result.value?.objectForKey("data")?.objectForKey("items")?.objectAtIndex(i).objectForKey("properties")?.objectForKey("first_name")
                                let lastNameJSON = response.result.value?.objectForKey("data")?.objectForKey("items")?.objectAtIndex(i).objectForKey("properties")?.objectForKey("last_name")
//                                let organizationNameJSON = response.result.value?.objectForKey("data")?.objectForKey("items")?.objectAtIndex(i).objectForKey("properties")?.objectForKey("title")
                                
                                var fullName = firstNameJSON as! String + " "
                                fullName += lastNameJSON as! String
                                
                                self.cellText.append(fullName)
                                
                              
//                                self.cellSub.append(organizationNameJSON as! String)
                                
                            }
                        }
                        
                        else {
                            for i in 0..<self.numResults {
                                let nameJSON = response.result.value?.objectForKey("data")?.objectForKey("items")?.objectAtIndex(i).objectForKey("properties")?.objectForKey("name")
                                self.cellText.append(nameJSON as! String)
                            }
                        }
                    }
                }
                
                self.loadActivityIndicator.stopAnimating()
                self.tableView.reloadData()
        }
    }
    
    func showAlerts(alertTitle: String, alertMessage: String) {
        
        let alertController = UIAlertController(
            title: alertTitle,
            message: alertMessage,
            preferredStyle: UIAlertControllerStyle.Alert
        )
        
        //                    let cancelAction = UIAlertAction(
        //                        title: "Cancel",
        //                        style: UIAlertActionStyle.Destructive) { (action) in
        //                            // ...
        //                    }
        
        let confirmAction = UIAlertAction(
            title: "OK", style: UIAlertActionStyle.Default) { (action) in
                // ...
        }
        
        alertController.addAction(confirmAction)
        //alertController.addAction(cancelAction)
        
        presentViewController(alertController, animated: true, completion: nil)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

//    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
//        
//        if numResults >= 100 {
//            numResults = 100
//        }
//        
//        print(numResults)
        
        return numResults
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...
        cell.textLabel!.text = cellText[indexPath.row]
//        cell.detailTextLabel!.text = cellSub[indexPath.row]

        return cell
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
