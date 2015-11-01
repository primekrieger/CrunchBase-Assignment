//
//  ViewController.swift
//  CrunchBase Assignment
//
//  Created by Diwakar Kamboj on 01/11/15.
//  Copyright © 2015 Nagarro. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let key = ""
        
        Alamofire.request(.GET, "https://api.crunchbase.com/v/3/organizations", parameters: ["name": "google", "user_key": key])
            .responseJSON { response in
//                print(response.request)  // original URL request
//                print(response.response) // URL response
//                print(response.data)     // server data
                print("Status: \(response.result)")   // result of response serialization
                
                if let num = response.result.value?.objectForKey("data")?.objectForKey("paging")?.objectForKey("total_items") as? NSNumber {
                    for i in 0..<num.integerValue {
                        let JSON = response.result.value?.objectForKey("data")?.objectForKey("items")?.objectAtIndex(i).objectForKey("properties")?.objectForKey("name")
                        print("JSON: \(JSON!)")
                    }
                }
//
//                if let JSON = response.result.value?.objectForKey("data")?.objectForKey("items")?.objectAtIndex(0).objectForKey("properties")?.objectForKey("name") {
//                    
//                }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

