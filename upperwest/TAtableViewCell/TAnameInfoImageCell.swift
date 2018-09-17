//
//  TAnameInfoImageCell.swift
//  NewYorkTour
//
//  Created by Taewook Noh on 2018. 5. 3..
//  Copyright © 2018년 taewook. All rights reserved.
//

import UIKit
import GooglePlaces

class TAnameInfoImageCell: UITableViewCell {

  
    @IBOutlet weak var taimage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()

        
        // Initialization code
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
                self.taimage.image = photo
            }
        })
    }
 
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
