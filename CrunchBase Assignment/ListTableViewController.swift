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

    
    var queryType = ""
    var query = ""
    var numResults = 0
    
    var op: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        let url = "https://api.crunchbase.com/v/3/" + queryType
        
        let key = ""
        
        Alamofire.request(.GET, url, parameters: ["name": query, "user_key": key])
            .responseJSON { response in
                //                print(response.request)  // original URL request
                //                print(response.response) // URL response
                //                print(response.data)     // server data
                print("Status: \(response.result)")   // result of response serialization
                
                if let num = response.result.value?.objectForKey("data")?.objectForKey("paging")?.objectForKey("total_items") as? NSNumber {
                    
                    self.numResults = num.integerValue
                    
                    for i in 0..<num.integerValue {
                        let JSON = response.result.value?.objectForKey("data")?.objectForKey("items")?.objectAtIndex(i).objectForKey("properties")?.objectForKey("name")
                        //print("JSON: \(JSON!)")
                        self.op.append(JSON as! String)
                    }
                }
                //
                //                if let JSON = response.result.value?.objectForKey("data")?.objectForKey("items")?.objectAtIndex(0).objectForKey("properties")?.objectForKey("name") {
                //                    
                //                }
                
                self.tableView.reloadData()
        }
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
        return numResults
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...
        cell.textLabel?.text = op[indexPath.row]

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
