//
//  User.swift
//  NewYorkTour
//
//  Created by Taewook Noh on 2018. 7. 20..
//  Copyright © 2018년 taewook. All rights reserved.
//

//
//  User.swift
//  LaDalle
//
//  Created by Loris Mazloum on 9/22/16.
//  Copyright © 2016 Loris Mazloum. All rights reserved.
//

import UIKit

struct User {
    let name: String
    let imageUrl: String?
    
    static func fromDictionary(dictionary: NSDictionary) -> User? {
        
        //Pull out each individual element from the dictionary
        guard
            let name = dictionary["name"] as? String
            else {
                return nil
        }
        
        //don't need that yet
        let imageUrl: String? = nil
        
        //Take the data parsed and create a Place Object from it
        return User(name: name, imageUrl: imageUrl)
    }
}

