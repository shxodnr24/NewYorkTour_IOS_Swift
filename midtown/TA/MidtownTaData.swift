//
//  MidtownTaData.swift
//  NewYorkTour
//
//  Created by Taewook Noh on 2018. 3. 27..
//  Copyright © 2018년 taewook. All rights reserved.
//

class MidtownTAData {
    var id: String?
    var info: String?
   
    var location : String?
    var homepage : String?
    var openinghour : [String : AnyObject]
    var placeID : String?
    
    
    init(id:String?, info:String?,location:String?, homepage:String?, openinghour:[String:AnyObject], placeID: String?) {
        self.id = id
        self.info = info
        self.location = location
        self.homepage = homepage
        self.openinghour = openinghour
        self.placeID = placeID
    }
}

/*
 var handle:DatabaseHandle?
 var ref: DatabaseReference!
class MidtownTaData: NSObject {
    let name: String?
    let address: String?
    let imageURL: URL?
    let categories: String?
    let distance: String?
    let ratingImageURL: URL?
    let reviewCount: NSNumber?

 init(dictionary: NSDictionary) {
    
    var handle:DatabaseHandle?
    var ref: DatabaseReference!
     handle = ref?.child("ta/Midtown").observe(DataEventType.value, with: {(snapshot) in
        
     })
    
    
    
    
    
    
    name = dictionary["name"] as? String
    
}
} */

