//
//  ViewController.swift
//  FilterDemo
//
//  Created by ramjan sayyad on 07/09/18.
//  Copyright © 2018 ramjan sayyad. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UIPickerViewDelegate,UIPickerViewDataSource{
    
    @IBOutlet weak var tableView: UITableView!

    @IBOutlet weak var pView: UIView!
    @IBOutlet weak var pickerView: UIPickerView!
    
    
    var personArray : Array<Any> = []
    var searching = false
    var searchPerson : Array<Any> = []
    var gender = ["male","female","other"]
    
    
    var Dictionary1 = [
        "name" : "Heena Sayyed",
        "gender" : "female"
    ]
    
    var Dictionary2 = [
        "name" : "Ramjan Sayyed",
        "gender" : "male"
    ]
    var Dictionary3 = [
        "name" : "Neha ",
        "gender" : "female"
    ]
    var Dictionary4 = [
        "name" : "Rahul ",
        "gender" : "male"
    ]
    
    var Dictionary5 = [
        "name" : "Karan Saxena ",
        "gender" : "other"
    ]
    
    // TableView DataSource Methods//
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        if searching
        {
            return searchPerson.count
        }
        else
        {
            return personArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        if searching
        {
            let temp_data = searchPerson[indexPath.row] as! [String:String]
            cell.textLabel?.text = temp_data["name"]
            cell.detailTextLabel?.text = temp_data["gender"]

        }else
        {
            let temp_data = personArray[indexPath.row] as! [String:String]
            cell.textLabel?.text = temp_data["name"]
            cell.detailTextLabel?.text = temp_data["gender"]
            
        }
        return cell
        
//       // let cell = UITableViewCell(style: UITableViewCellStyle.value1, reuseIdentifier: "cell")
//
//        let temp_data = arrayData[indexPath.row] as! [String:String]
//
//        cell.textLabel?.text = temp_data["Question"]
//        //cell.ansLabel.text = temp_data["Answer"]!
//        // cell
    }
    
//PickerView DataSource and Delegate Methods//
    
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
     return 1
   }

  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
      return gender[row]
  }
   func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
       return gender.count
 }
//
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
////        //searchPerson = personArray.filter{ $0["gender"] == gender[row] }
////       // searchPerson = personArray.filter{$0.gender == searchPerson}
////       // var searchPerson:[String:AnyObject] = personArray.filter{($0[gender[row]] as! String) ==  "gender"}
////    //var dict:[[String:AnyObject]] = personArray.filter{($0["parentId"] as! String) == "compareId"}
////
////        ////////////////////////////////////////////////////////////////////
////        //For displaying the record accordingly the selection on picker view
////
////
//        _ = NSPredicate(format: "gender == %@", gender[row])
//        let array = (personArray as NSArray).filtered(using: searchPredicate)
//        print ("array = \(array)")
//        searchPerson = array
//        searching = true
//        tableView.reloadData()
        
        
    }
//    //{ $0.itemName == filterItemName }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        personArray = [Dictionary1,Dictionary2,Dictionary3,Dictionary4,Dictionary5]
        pView.isHidden = true
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func filterBtn(_ sender: Any)
    {
        if pView.isHidden == true
        {
        pView.isHidden = false
        }
        else
        {
            pView.isHidden = true
        }
        }
    
    @IBAction func cancelbtn(_ sender: Any)
    {
        searching = false

        personArray = [Dictionary1,Dictionary2,Dictionary3,Dictionary4,Dictionary5]
        pView.isHidden = true
        tableView.reloadData()
        
    }

    @IBAction func doneBtn(_ sender: Any) {
       
         DispatchQueue.main.async() {
        let searchPredicate = NSPredicate(format: "gender == %@", self.gender[self.pickerView.selectedRow(inComponent: 0)])
        let array = (self.personArray as NSArray).filtered(using: searchPredicate)
        print ("array = \(array)")
        self.searchPerson = array
        self.searching = true
        
       
            self.tableView.reloadData()
        }
        
        
    }
}

