//
//  UpperWestRestaurantFilter.swift
//  NewYorkTour
//
//  Created by Taewook Noh on 2018. 6. 4..
//  Copyright © 2018년 taewook. All rights reserved.
//

import UIKit

@objc protocol UWRFD {
    @objc  optional func UpperWestRestaurantFilter(restaurantFilter: UpperWestRestaurantFilter, didUpdateFilters filters: [String : AnyObject])
    
}

class UpperWestRestaurantFilter: UIViewController, UITableViewDataSource, UITableViewDelegate,SwitchCellDelegate {

    
    @IBOutlet weak var tableView: UITableView!
    var categories : [[String:String]]!
    var switchStates = [Int:Bool]()
    
 
    weak var delegate : UWRFD?
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        
        categories = yelpCategories()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    @IBAction func onCancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
//    @IBAction func onSearchButton(_ sender: Any) {
//        dismiss(animated: true, completion: nil)
//        var filters = [String : AnyObject]()
//
//        var selectedCategories = [String]()
//        for(row,isSelected) in switchStates {
//            if isSelected {
//                selectedCategories.append(categories[row]["code"]!)
//            }
//        }
//        if selectedCategories.count > 0 {
//            filters["categories"] = selectedCategories as AnyObject
//        }
//        // MidtownRestaurant.cateFilter(filters)
//        delegate?.UpperWestRestaurantFilter?(restaurantFilter:self, didUpdateFilters: filters)
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func yelpCategories() -> [[String:String]] {
        return [["name" : "American New", "code" : "newamerican"],
                ["name" : "American", "code" : "american"],
                ["name" : "Asian Fusion" , "code" : "asianfusion"],
                ["name" : "Korean" , "code" : "korean"],
                ["name" : "Arabian" , "code" : "arabian"],
                ["name" : "Brazilian" , "code" : "brazilian"],
                ["name" : "British" , "code" : "british"],
                ["name" : "Bulgarian" , "code" : "bulgarian"],
                ["name" : "Burgers" , "code" : "burgers"],
                ["name" : "Cafes" , "code" : "cafes"],
                ["name" : "Caribbean" , "code" : "caribbean"],
                ["name" : "Chinese" , "code" : "chinese"],
                ["name" : "Cuban" , "code" : "cuban"],
                ["name" : "Fast Food" , "code" : "hotdogs"]]
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SwithCell", for: indexPath) as! SwithCell
        
        cell.switchlabel.text = categories[indexPath.row]["name"]
        cell.delegate = self
        
        
        cell.onSwitch.isOn = switchStates[indexPath.row] ?? false
        return cell
    }
    
    func switchCell(switchCell: SwithCell, didChangeValue value: Bool) {
        let indexPath = tableView.indexPath(for: switchCell)!
        switchStates[indexPath.row] = value
        print("fillter view controll got the switch event")
    }
    
    
    @IBAction func onSearchAction(_ sender: Any) {
      
        var filters = [String : AnyObject]()
        
        var selectedCategories = [String]()
        for(row,isSelected) in switchStates {
            if isSelected {
                selectedCategories.append(categories[row]["code"]!)
            }
        }
        if selectedCategories.count > 0 {
            filters["categories"] = selectedCategories as AnyObject
        }
        // MidtownRestaurant.cateFilter(filters)
        delegate?.UpperWestRestaurantFilter?(restaurantFilter:self, didUpdateFilters: filters)
        _ = navigationController?.popViewController(animated: true)
    }
    
}
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


