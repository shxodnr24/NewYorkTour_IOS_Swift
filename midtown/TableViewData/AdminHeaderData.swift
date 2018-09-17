//
//  AdminHeaderData.swift
//  NewYorkTour
//
//  Created by Taewook Noh on 2018. 4. 3..
//  Copyright © 2018년 taewook. All rights reserved.
//

import Foundation

struct Section {
var section:String!
var data:[String]!
var expanded: Bool!

init(section: String, data: [String], expanded : Bool)
{
    self.section = section
    self.data = data
    self.expanded = expanded
}

}

