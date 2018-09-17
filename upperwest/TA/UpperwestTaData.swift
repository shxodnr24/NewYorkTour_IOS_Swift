//
//  UpperwestTaData.swift
//  NewYorkTour
//
//  Created by Taewook Noh on 2018. 3. 30..
//  Copyright © 2018년 taewook. All rights reserved.
//

class UpperwestTaData {
    var id : String?
    var info : String?
    var location : String?
    var homepage : String?
    var openingHour : [String : AnyObject]
    var placeID : String?
    
    init(id:String?, info:String?, location:String?, homepage:String?, openingHour:[String:AnyObject], placeID:String?)
    {
        self.id = id 
        self.info = info
        self.location = location
        self.homepage = homepage
        self.openingHour = openingHour
        self.placeID = placeID
        
    }
    
}
