//
//  UpperEastTAdetailMap.swift
//  NewYorkTour
//
//  Created by Taewook Noh on 2018. 4. 20..
//  Copyright © 2018년 taewook. All rights reserved.
//

import UIKit
import GoogleMaps

class UpperEastTAdetailMap: UIViewController {
    var latitude:Double?
    var longtitude:Double?
    override func viewDidLoad() {
        super.viewDidLoad()
      
      
        // Do any additional setup after loading the view.
    }
    
    func receive(latitude:Double, longtitude:Double, id:String) {
        self.latitude = latitude
        self.longtitude = longtitude
        print(self.latitude!)
        print(self.longtitude!)
        
        
        let camera = GMSCameraPosition.camera(withLatitude: latitude, longitude: longtitude, zoom: 15.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.isMyLocationEnabled = true
        view = mapView
        
        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: latitude, longitude: longtitude)
        marker.title = id
        marker.snippet = "Tourist Attraction"
        
        marker.map = mapView
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
