//
//  UpperwestTAurlCell.swift
//  NewYorkTour
//
//  Created by Taewook Noh on 2018. 5. 11..
//  Copyright © 2018년 taewook. All rights reserved.
//

import UIKit

class UpperwestTAurlCell: UITableViewCell {

    @IBOutlet weak var urlButton: UIButton!
    // @IBOutlet weak var urlCell: UILabel!
    @IBOutlet weak var nameCell: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        let text01 = urlButton.currentTitle
        
     //  "http//" + urlButton.currentTitle!
        // Initialization code
    }
   
    @IBAction func connectURL(_ sender: Any) {
        let text01 = urlButton.currentTitle
        let indexStartofText = text01?.index((text01?.startIndex)!, offsetBy: 2)
        //let subString = text01[indexStartofText]
        
       // print(subString)
//
//        let alert = UIAlertController(title: "Homepage Moving", message: urlButton.currentTitle!, preferredStyle: UIAlertControllerStyle.alert)
//        alert.addAction(UIAlertAction(title: "cancel", style: .cancel, handler: nil))
//        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
//            UIApplication.shared.open(URL(string: self.urlButton.currentTitle!)! as URL, options: [:], completionHandler: nil)
//
//
//        }))
        
     /*   alert.addAction(UIAlertAction(title: "cancel", style: .cancel, handler: { action in
            switch action.style{
            case .default:
                print("default")
                
            case .cancel:
                print("cancel")
                
            case .destructive:
                print("destructive")
                
                
            }})) */
        
//        UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
       // self.present(alert, animated: true, completion: nil)
        
        
    print("It is clicked")
//        UIApplication.shared.open(URL(string: "http://www.facebook.com")! as URL, options: [:], completionHandler: nil)
      
    }
    
   

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
