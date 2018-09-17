//
//  Review.swift
//  NewYorkTour
//
//  Created by Taewook Noh on 2018. 7. 20..
//  Copyright © 2018년 taewook. All rights reserved.
//


import UIKit

struct Review {
    let text: String
    let user: User
    let url: String
    let rating: Double
    let timeCreated: String
    
    static func fromDictionary(dictionary: NSDictionary) -> Review? {
        
        //Pull out each individual element from the dictionary
        guard
            let text = dictionary["text"] as? String,
            let url = dictionary["url"] as? String,
            let rating = dictionary["rating"] as? Double,
            let timeCreated = dictionary["time_created"] as? String
            else {
                print("Error getting basic fields")
                return nil
        }
        
        //create user
        guard let userDictionary = dictionary["user"] as? NSDictionary else { print("Error creating the user dictionary"); return nil }
        guard let user = User.fromDictionary(dictionary: userDictionary) else { print("Error creating the user object"); return nil}
        
        
        //Take the data parsed and create a Place Object from it
        return Review(text: text, user: user, url: url, rating: rating, timeCreated: timeCreated)
    }
}

