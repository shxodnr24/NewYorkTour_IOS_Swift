//
//  LowerManhattanFirst.swift
//  NewYorkTour
//
//  Created by Taewook Noh on 2017. 12. 29..
//  Copyright © 2017년 taewook. All rights reserved.
//

import UIKit
import GoogleMobileAds

class LowerManhattanFirst: UIViewController {
    
  var banner: GADBannerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        loadbanner()
        // Do any additional setup after loading the view, typically from a nib.
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
    
    @IBAction func backButton(_ sender: Any) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let nextView = storyboard.instantiateInitialViewController()
        present(nextView!, animated: true, completion: nil)
    }
    
}

