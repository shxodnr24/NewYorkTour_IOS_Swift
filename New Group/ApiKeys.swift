//
//  ApiKeys.swift
//  NewYorkTour
//
//  Created by Taewook Noh on 2018. 7. 20..
//  Copyright © 2018년 taewook. All rights reserved.
//

import UIKit
import Foundation

func valueForAPIKey(named keyname:String) -> String {
    // Credit to the original source for this technique at
    // http://blog.lazerwalker.com/blog/2014/05/14/handling-private-api-keys-in-open-source-ios-apps
    let filePath = Bundle.main.path(forResource: "ApiKeys", ofType: "plist")
    let plist = NSDictionary(contentsOfFile:filePath!)
    let value = plist?.object(forKey: keyname) as! String
    return value
}

func setValueForAPIKey(named keyname:String, value: String) {
    
}
