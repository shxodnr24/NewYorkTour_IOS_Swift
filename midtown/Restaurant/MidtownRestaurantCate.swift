//
//  MidtownRestaurantCate.swift
//  NewYorkTour
//
//  Created by Taewook Noh on 2018. 7. 23..
//  Copyright © 2018년 taewook. All rights reserved.
//

import UIKit
import CoreLocation
import GoogleMobileAds

class MidtownRestaurantCate: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var categories = Category.loadDefaults()
     var banner:GADBannerView!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        reload()
        super.viewDidLoad()
        loadbanner()
        // Do any additional setup after loading the view.
    }
    
    func reload() {
        //        let data2 = CLLocationCoordinate2D(latitude: 40.718696, longitude: -73.987231)
        let data2 = CLLocationCoordinate2D(latitude: 40.747823, longitude: -73.987149)
        Category.getCategories(for: data2, categorySearchCompletionHandler: {(category) in
            DispatchQueue.main.async {
                self.categories = category
                self.tableView.reloadData()
            }
        })
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cateCell", for: indexPath)
          let category = categories[indexPath.row]
        cell.textLabel?.text = category.title
        
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

  
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toyelpTable"
        {
            if let indexPath = tableView.indexPathForSelectedRow {
                 guard let destination = segue.destination as? MidtownRestaurant else { return }
                 let category = categories[indexPath.row]
                 destination.category = category
        }
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
  

}

}
