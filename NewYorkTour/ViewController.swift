//
//  ViewController.swift
//  NewYorkTour
//
//  Created by Taewook Noh on 2017. 12. 12..
//  Copyright © 2017년 taewook. All rights reserved.
//

import UIKit
import GoogleMobileAds

class ViewController: UIViewController {

    var banner: GADBannerView!
    
    @IBOutlet weak var TestLabel: UILabel!
  
    @IBAction func barMenuOpen(_ sender: Any) {
        print("barMenu has Opend")
        NotificationCenter.default.post(name: NSNotification.Name("ToggleSideMenu"), object: nil)
        
    }
  
    
    
    func loadBanner() {
        banner = GADBannerView(adSize: kGADAdSizeSmartBannerPortrait)
        banner.adUnitID = "ca-app-pub-4456961390591909/9717581265"
        banner.rootViewController = self
        let req : GADRequest = GADRequest()
        banner.load(req)
//        banner.frame = CGRect(x: 0, y: view.bounds.height - banner.frame.size.height, width: banner.frame.size.width, height: banner.frame.size.height)
        
        self.view.addSubview(banner)
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
    
    @IBOutlet weak var lowermahnattan: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        loadBanner()
        banner = GADBannerView(adSize: kGADAdSizeBanner)
        addBannerViewToView(banner)
        banner.rootViewController = self
        // Set the ad unit ID to your own ad unit ID here.
        banner.adUnitID = "ca-app-pub-4456961390591909/9717581265"
        banner.load(GADRequest())
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

