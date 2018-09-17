//
//  FoodSelected.swift
//  NewYorkTour
//
//  Created by Taewook Noh on 2018. 2. 26..
//  Copyright © 2018년 taewook. All rights reserved.
//

import UIKit
class FoodSelected: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickFood.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickFood[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickText.text = pickFood[row]
    }
    
    
    
    
    @IBOutlet weak var pickText: UITextField!
    var pickFood=["American", "Japanese", "Korean", "Chinese", "Spanish"]
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        var pickerView = UIPickerView()
        pickerView.delegate = self
        
        pickText.inputView = pickerView
        // Do any additional setup after loading the view, typically from a nib.
    }
    
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
 
    
}

