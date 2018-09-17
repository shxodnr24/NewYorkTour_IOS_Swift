//
//  LowerManhattanRestaurantDetail2.swift
//  NewYorkTour
//
//  Created by Taewook Noh on 2018. 5. 29..
//  Copyright © 2018년 taewook. All rights reserved.
//

import UIKit
import MapKit

class LowerManhattanRestaurantDetail2: UITableViewController {
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var displayPhoneLabel: UILabel!
    @IBOutlet weak var displayAddressLabel: UILabel!
    @IBOutlet weak var businessImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var categoriesLabel: UILabel!
    @IBOutlet weak var ratingImageView: UIImageView!
    
    @IBOutlet weak var isClosedLabel: UILabel!
    
    @IBOutlet weak var numReviewsLabel: UILabel!
    
     var business: Business!
    var category : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 50
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    fileprivate func setupViews() {
        setupLabels()
        setupImageViews()
        setupAnnotation()
    }
    
    
    fileprivate func setupLabels() {
        self.nameLabel.text = business.name
        self.numReviewsLabel.text = "\(business.reviewCount) Reviews"
        self.categoriesLabel.text = category!
        
        if let isClosed = business.isClosed, isClosed {
            isClosedLabel.text = "Closed"
            isClosedLabel.textColor = .red
        } else {
            isClosedLabel.text = "Open"
            isClosedLabel.textColor = .green
        }
        
        //        let url = NSURL(string: "tel://\(business.displayPhone!)")!
        //        if #available(iOS 10.0, *) {
        //            UIApplication.shared.open(url as URL)
        //        } else {
        //            UIApplication.shared.openURL(url as URL)
        //        }
        displayAddressLabel.text = "Address : \(business.subtitle!)"
        displayPhoneLabel.text = "Phone : \(business.displayPhone!)"
    }
    
    fileprivate func setupImageViews() {
        let ratingImageName = Business.getRatingImage(rating: business.rating)
        self.ratingImageView.image = UIImage(named: ratingImageName)
        
        let url = URL(string: business.imageUrl)
        let data = try? Data(contentsOf: url!)
        businessImageView.image = UIImage(data: data!)
    }
    
    fileprivate func setupAnnotation() {
        let latitude = business.coordinate.latitude
        let longitude = business.coordinate.longitude
        
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        
        mapView.addAnnotation(annotation)
        mapView.showAnnotations([annotation], animated: true)
        
        if mapView.selectedAnnotations.count > 0
        {
            print("is it clicked")
        }
        
        
        
    }

}
