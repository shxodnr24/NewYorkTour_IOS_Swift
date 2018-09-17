//
//  GooglePlaceCell.swift
//  NewYorkTour
//
//  Created by Taewook Noh on 2018. 5. 30..
//  Copyright © 2018년 taewook. All rights reserved.
//

import UIKit
import GooglePlaces

class GooglePlaceCell: UITableViewCell {

 
    @IBOutlet weak var ImageView: UIImageView!
    
    @IBOutlet weak var nameCell: UILabel!
    
    @IBOutlet weak var addressCell: UILabel!
    
    @IBOutlet weak var openCell: UILabel!
    
    var placeID:String?
    var placesClient: GMSPlacesClient!
    var number:Int?
    
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
                self.number = self.number! + 1
            
                print("Place name \(place.name)")
                print("Place address \(place.formattedAddress)")
                print("Place placeID \(place.placeID)")
                print("Place attributions \(place.attributions)")
                print("Place WebPage \(place.website)")
                print("place Opennow \(place.openNowStatus.rawValue)")
                self.nameCell.text = ("\(self.number!) \(place.name)")
                self.addressCell.text = place.formattedAddress
            
                self.openCell.text = place.types[0]
           
            
         
                
            })
        }
        
    
    
    
    func loadfirstImage(placeid: String){
        GMSPlacesClient.shared().lookUpPhotos(forPlaceID: placeid) { (photos, error) -> Void in
            if let error = error {
                print("Error : \(error.localizedDescription)")
            } else {
                if let firstphoto = photos?.results.first {
                    self.loadImageforMetaData(photoMetadata: firstphoto)
                }
            }
        }
    }
    func loadImageforMetaData(photoMetadata: GMSPlacePhotoMetadata) {
        GMSPlacesClient.shared().loadPlacePhoto(photoMetadata, callback: {(photo, error)-> Void in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            } else {
                self.ImageView.image = photo
            }
        })
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
