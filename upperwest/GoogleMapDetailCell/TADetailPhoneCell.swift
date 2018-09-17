//
//  TADetailPhoneCell.swift
//  NewYorkTour
//
//  Created by Taewook Noh on 2018. 6. 1..
//  Copyright © 2018년 taewook. All rights reserved.
//

import UIKit
import GooglePlaces

class TADetailPhoneCell: UITableViewCell {

    @IBOutlet weak var descriptionCell: UILabel!
    @IBOutlet weak var phoneCell: UILabel!
     var placesClient: GMSPlacesClient!
    override func awakeFromNib() {
        super.awakeFromNib()
         placesClient = GMSPlacesClient.shared()
        // Initialization code
    }

    
    func lookup(placeid: String) {
        let placeidnumber = placeid
        print("이거 값좀 알려줘:", placeid)
        placesClient.lookUpPlaceID(placeid, callback: { (place, error) -> Void in
            if let error = error {
                print("lookup place id query error: \(error.localizedDescription)")
                return
            }
            
            guard let place = place else {
                print("No place details for \(placeid)")
                return
            }
            
            
           self.phoneCell.text = place.formattedAddress
            self.descriptionCell.text = "Address"
            
            
            
            
        })
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
