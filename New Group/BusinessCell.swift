//
//  BusinessCell.swift
//  NewYorkTour
//
//  Created by Taewook Noh on 2018. 3. 5..
//  Copyright © 2018년 taewook. All rights reserved.
//

import UIKit

class BusinessCell: UITableViewCell {
    @IBOutlet weak var namecell: UILabel!
    @IBOutlet weak var distancecell: UILabel!
    
    @IBOutlet weak var thumbimage: UIImageView!
    @IBOutlet weak var rateimageview: UIImageView!
    @IBOutlet weak var countrycell: UILabel!
    @IBOutlet weak var addresscell: UILabel!
    @IBOutlet weak var reviewcell: UILabel!
    @IBOutlet weak var pricecell: UILabel!
    
//    var business : Business! {
//        didSet {
//            namecell.text = business.name
//            thumbimage.setImageWith(business.imageURL!)
//            distancecell.text = business.distance
//            rateimageview.setImageWith(business.ratingImageURL!)
//            countrycell.text = business.categories
//            addresscell.text = business.address
//            reviewcell.text = "\(business.reviewCount!) Reviews"
//
//        }
//    }
    override func awakeFromNib() {
        super.awakeFromNib()
        thumbimage.layer.cornerRadius = 3
        thumbimage.clipsToBounds = true
        namecell.preferredMaxLayoutWidth = namecell.frame.size.width
        
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        namecell.preferredMaxLayoutWidth = namecell.frame.size.width
    }
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
