//
//  TAnamecell.swift
//  NewYorkTour
//
//  Created by Taewook Noh on 2018. 5. 5..
//  Copyright © 2018년 taewook. All rights reserved.
//

import UIKit

class TAnamecell: UITableViewCell {

    @IBOutlet weak var taname: UILabel!
    
    @IBOutlet weak var subjectCell: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
