//
//  YelpAnnotation.swift
//  NewYorkTour
//
//  Created by Taewook Noh on 2018. 5. 29..
//  Copyright © 2018년 taewook. All rights reserved.
//

import MapKit

class YelpAnnotation: NSObject, MKAnnotation {
    
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    var atIndex: Int?
    
    init(coordinate: CLLocationCoordinate2D, at index: Int) {
        self.coordinate = coordinate
        self.atIndex = index
        title = nil
        subtitle = nil
    }
}
