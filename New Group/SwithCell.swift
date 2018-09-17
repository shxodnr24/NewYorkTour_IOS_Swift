//
//  SwithCell.swift
//  NewYorkTour
//
//  Created by Taewook Noh on 2018. 3. 13..
//  Copyright © 2018년 taewook. All rights reserved.
//

import UIKit

@objc protocol SwitchCellDelegate {
    @objc optional func switchCell(switchCell: SwithCell,
        didChangeValue value:Bool )
}
class SwithCell: UITableViewCell {

    @IBOutlet weak var switchlabel: UILabel!
    
    @IBOutlet weak var onSwitch: UISwitch!
    
    weak var delegate: SwitchCellDelegate?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
      /*   onSwitch.addTarget(self, action: Selector("switchValueChanged:"), for: UIControlEvents.valueChanged)*/
       if  onSwitch.isOn {
            print("Switch is on")
         onSwitch.setOn(true, animated: true)
       }else{
        print("Switch is off")
         onSwitch.setOn(false, animated: true)
        }
        
       // onSwitch.setOn(true, animated: true)
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

  
    @IBAction func swithchanged(_ sender: Any) {
         delegate?.switchCell?(switchCell: self, didChangeValue: onSwitch.isOn)
    }
    
  func switchValueChanged() {
   
    }
}
