//
//  TAinfoOpeningHour.swift
//  NewYorkTour
//
//  Created by Taewook Noh on 2018. 5. 16..
//  Copyright © 2018년 taewook. All rights reserved.
//

import UIKit

class TAinfoOpeningHour: UITableViewCell {
    @IBOutlet weak var nameCell: UILabel!
    
    @IBOutlet weak var monCell: UILabel!
    
    @IBOutlet weak var tueCell: UILabel!
    
    @IBOutlet weak var wedCell: UILabel!
    
    @IBOutlet weak var friCell: UILabel!
    @IBOutlet weak var thuCell: UILabel!
    
    @IBOutlet weak var satCell: UILabel!
    
    @IBOutlet weak var sunCell: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
