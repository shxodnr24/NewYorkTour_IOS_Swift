//
//  UpperEastRestaurant.swift
//  NewYorkTour
//
//  Created by Taewook Noh on 2018. 4. 19..
//  Copyright © 2018년 taewook. All rights reserved.
//

import UIKit
import GoogleMobileAds
import CoreLocation

class UpperEastRestaurant: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var businesses = [Business]()
    var banner:GADBannerView!
    var category : Category?
    var currentcategoryIs : String?

    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        indicatorView.startAnimating()
        loadbanner()
        reload()
        self.view.addSubview(indicatorView)
        
        guard let currentCategory = self.category else {return}
        currentcategoryIs = currentCategory.title
       tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120

    }
    
    private let main = OperationQueue.main
    private let async: OperationQueue = {
        //The Queue is being created by this closure
        let operationQueue = OperationQueue()
        //This represents how many tasks can run at the same time, in this case 8 tasks
        //That means that we can load 8 images at a time
        operationQueue.maxConcurrentOperationCount = 8
        return operationQueue
    }()
    
    func reload() {
   
        let data2 = CLLocationCoordinate2D(latitude: 40.779500, longitude: -73.955833)
  
        DispatchQueue.global().async {
            guard let currentCategory = self.category else { return }
            
            Business.getLocalPlaces(forCategory: currentCategory.alias, coordinates: data2, completionHandler: { (business) in
                
                
                
                let delayTime = DispatchTime.now() + 2
                DispatchQueue.main.asyncAfter(deadline: delayTime) {
                    
                    self.businesses = business
                    self.tableView.reloadData()
                    self.indicatorView.stopAnimating()
                    self.indicatorView.hidesWhenStopped = true
                }
                
            })
        }
        
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return businesses.count
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "BusinessCell", for: indexPath) as! BusinessCell
        
         let business = businesses[indexPath.row]
        
        cell.namecell.text = business.name
        cell.addresscell.text = business.subtitle
        cell.reviewcell.text = "\(String(business.reviewCount))Reviews"
        cell.countrycell.text = currentcategoryIs!
        cell.distancecell.text = business.distance
        let ratingImageName = Business.getRatingImage(rating: business.rating)
        cell.rateimageview.image = UIImage(named: ratingImageName)
        cell.pricecell.text = business.price
        
        let url = URL(string: business.imageUrl)
      
        let data = try? Data(contentsOf: url!)
        cell.thumbimage.image = UIImage(data: data!)
        return cell
    }
    
    func loadbanner() {
        banner = GADBannerView(adSize: kGADAdSizeBanner)
        addBannerViewToView(banner)
        banner.rootViewController = self
        // Set the ad unit ID to your own ad unit ID here.
        banner.adUnitID = "ca-app-pub-4456961390591909/9717581265"
        banner.load(GADRequest())
    }
    
    func addBannerViewToView(_ bannerView: UIView) {
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bannerView)
        if #available(iOS 11.0, *) {
            positionBannerAtBottomOfSafeArea(bannerView)
        }
        else {
            positionBannerAtBottomOfView(bannerView)
        }
    }
    func positionBannerAtBottomOfSafeArea(_ bannerView: UIView) {
        // Position the banner. Stick it to the bottom of the Safe Area.
        // Centered horizontally.
        let guide: UILayoutGuide = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate(
            [bannerView.centerXAnchor.constraint(equalTo: guide.centerXAnchor),
             bannerView.bottomAnchor.constraint(equalTo: guide.bottomAnchor)]
        )
    }
    
    func positionBannerAtBottomOfView(_ bannerView: UIView) {
        // Center the banner horizontally.
        view.addConstraint(NSLayoutConstraint(item: bannerView,
                                              attribute: .centerX,
                                              relatedBy: .equal,
                                              toItem: view,
                                              attribute: .centerX,
                                              multiplier: 1,
                                              constant: 0))
        // Lock the banner to the top of the bottom layout guide.
        view.addConstraint(NSLayoutConstraint(item: bannerView,
                                              attribute: .bottom,
                                              relatedBy: .equal,
                                              toItem: self.bottomLayoutGuide,
                                              attribute: .top,
                                              multiplier: 1,
                                              constant: 0))
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       if segue.identifier == "restaurantDetail"
        {
            let move = segue.destination as! UpperEastRestaurantDetail2
            let selectedPath = self.tableView.indexPathForSelectedRow!
            
            move.business = businesses[selectedPath.row]
            move.category = currentcategoryIs
            
        }
    }
    
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    



    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
