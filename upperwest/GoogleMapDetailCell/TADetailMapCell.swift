//
//  TADetailMapCell.swift
//  NewYorkTour
//
//  Created by Taewook Noh on 2018. 6. 1..
//  Copyright © 2018년 taewook. All rights reserved.
//

import UIKit
import MapKit
import GooglePlaces

class TADetailMapCell: UITableViewCell {

    @IBOutlet weak var mapView: MKMapView!
     var placesClient: GMSPlacesClient!
    override func awakeFromNib() {
        super.awakeFromNib()
          placesClient = GMSPlacesClient.shared()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
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
            
            self.configure(coordinate: place.coordinate, title: place.name)
         
            
            
            
        })
    }
    
    func configure(coordinate: CLLocationCoordinate2D, regionDistance: Double = 300.0, title:String?) {
        
      
        
        
        var placemarker : MKPlacemark = MKPlacemark(coordinate: coordinate, addressDictionary: nil)
        let newRegion = MKCoordinateRegionMakeWithDistance(coordinate, regionDistance, regionDistance)
        
        mapView.setRegion(newRegion, animated: false)
        
        let annotation = MKPointAnnotation()
        
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: newRegion.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: newRegion.span)
        ]
        
        annotation.coordinate = coordinate
        annotation.title = title
        annotation.subtitle = "hello2"
        mapView.addAnnotation(annotation)
        
        //    let mapItem = MKMapItem(placemark: placemarker)
        //        if mapItem.
        //      mapItem.name = "\(self.addressString!)"
        //      mapItem.openInMaps(launchOptions: options)
       
    }

}
