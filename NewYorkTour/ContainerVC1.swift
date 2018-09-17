//
//  ContainerVC1.swift
//  NewYorkTour
//
//  Created by Taewook Noh on 2018. 4. 17..
//  Copyright © 2018년 taewook. All rights reserved.
//

import UIKit

class ContainerVC1: UITableViewController {
    
    var word = ["Login", "Profile", "Date"]

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
          NotificationCenter.default.post(name: NSNotification.Name("ToggleSideMenu"), object: nil)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "optionMenu", for:indexPath)
        cell.textLabel?.text = word[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return word.count
    }
}
