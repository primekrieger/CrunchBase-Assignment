//
//  HomeViewController.swift
//  CrunchBase Assignment
//
//  Created by Diwakar Kamboj on 01/11/15.
//  Copyright © 2015 Nagarro. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var inputQuery: UITextField!
    
    var queryType = "organizations"
    
    var pickerDataSource = ["Organizations", "People", "Products"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //print(typePicker.selected)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerDataSource.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerDataSource[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        if(row == 0)
        {
            queryType = "organizations"
        }
        else if(row == 1)
        {
            queryType = "people"
        }
        else
        {
            queryType = "products"
        }
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        let destController = segue.destinationViewController as! ListTableViewController
        
        destController.queryType = queryType
        destController.query = inputQuery.text!
        
//        if segue.identifier == "showDetail" {
//        segue.destinationViewController
//        }
        
    }
    

}
