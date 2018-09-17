//
//  MidtownRestaurant.swift
//  NewYorkTour
//
//  Created by Taewook Noh on 2018. 3. 19..
//  Copyright © 2018년 taewook. All rights reserved.
//
struct restaurantdata {
    let name: String
    let address: String
    let rating: String
 
}
import UIKit
import GoogleMobileAds
import ObjectMapper
import CoreLocation

class MidtownRestaurant: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    
  
    var category : Category?
    var businesses = [Business]()
    var banner: GADBannerView!
    var currentcategoryIs : String?
    
    var test = [String]()
    var completionHandler : [() -> Void] = []
    
   
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var TestLabel: UILabel!
    override func viewDidLoad() {
        self.view.addSubview(indicatorView)
        indicatorView.startAnimating()
        guard let currentCategory = self.category else {return}
        currentcategoryIs = currentCategory.title
        super.viewDidLoad()
        tableview.delegate = self
        tableview.dataSource = self
        tableview.rowHeight = UITableViewAutomaticDimension
        tableview.estimatedRowHeight = 120
        loadbanner()
        reload()

    }
  


    
    func reload() {
        let data2 = CLLocationCoordinate2D(latitude: 40.718696, longitude: -73.987231)
        
        DispatchQueue.global().async {
            guard let currentCategory = self.category else { return }
            
            Business.getLocalPlaces(forCategory: currentCategory.alias, coordinates: data2, completionHandler: { (business) in
                
                
                
                let delayTime = DispatchTime.now() + 2
                DispatchQueue.main.asyncAfter(deadline: delayTime) {
                    
                    self.businesses = business
                    self.tableview.reloadData()
                    self.indicatorView.stopAnimating()
                    self.indicatorView.hidesWhenStopped = true
                }
                
            })
        }
        
    }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        
        return businesses.count

    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableview.dequeueReusableCell(withIdentifier: "BusinessCell", for: indexPath) as! BusinessCell
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
        
//        cell.imageView?.image = UIImage(data: data!)
        
       
//         let tourlist : MidtownRestaurantData
//        tourlist = restaurantdata[indexPath.row]
//        cell.namecell.text = self.restauranttests[indexPath.row]["name"]
//        cell.namecell.text = tourlist.name
//        cell.namecell.text = restaurants[indexPath.row]["name"]!
//        cell.business = businesses[indexPath.row]
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
        
    
        if segue.identifier == "restaurantDetail" {
            let move = segue.destination as! MidtownRestaurantDetail
            let selectedPath = self.tableview.indexPathForSelectedRow!
            
            move.business = businesses[selectedPath.row]
            move.category = currentcategoryIs
            
        }
        
    }
    

}

