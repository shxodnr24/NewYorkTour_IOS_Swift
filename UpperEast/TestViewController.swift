//
//  TestViewController.swift
//  NewYorkTour
//
//  Created by Taewook Noh on 2018. 4. 26..
//  Copyright © 2018년 taewook. All rights reserved.
//

import UIKit
import CascadingTableDelegate
import CoreLocation

struct DestinationInfo1 {
    let type: String
    let text: String
}

class TestViewController: UIViewController  {
   
    var address:String?
    var name:String?
    var infomation:String?
    lazy var geocoder = CLGeocoder()
    
    var sitemap = "www.google.com"
    var number = "+1 200-3000-4000"
    var addressinfo = [DestinationInfo1]()
    @IBOutlet weak var tableView: UITableView!
    fileprivate let refreshControl = UIRefreshControl()
    var window: UIWindow?
    var uiview: UIViewController?
   fileprivate let viewModel = DestinationViewModel()
    
fileprivate var rootDelegate: CascadingRootTableDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        let navigationBar = self.navigationController?.navigationBar
        navigationBar?.barTintColor = UIColor.cst_DarkBlueGrey
        
        createRootDelegate()
        configureRefreshControl()
        let info = [("Address", address),
                           ("Website", sitemap),
                           ("Phone", number)]
        
        geocoder.geocodeAddressString(address!) {
            (CLPlacemark, error) in
            self.processResponse(withPlacemarks: CLPlacemark, error: error)
        }
        viewModel.name = name
      viewModel.test1 = address
        viewModel.info = infomation
         //Location Info 전해주는 값
       viewModel.locationinfo = info.map({ type, text -> DestinationInfo in
            return DestinationInfo(type: type, text: text!)
            
        })
        
    
       
      
       /* let windowFrame = UIScreen.main.bounds
        window = UIWindow(frame: windowFrame)
        uiview = UIViewController(nibName: "DestinationViewController", bundle: nil)
        
        
        let welcomeViewController = DestinationViewController()
        let rootNavController = UINavigationController(rootViewController: welcomeViewController)
        let testController = UINavigationController(nibName: "DestinationViewController", bundle: nil)
        window?.rootViewController = rootNavController
        
        window?.makeKeyAndVisible()
        */
      

        // Do any additional setup after loading the view.
    }

    
    fileprivate func createRootDelegate() {
        
        // Feel free to remove, add, copy, or change this array's value. The rootTableDelegate will do the heavy-lifting and display the correct result for you :)
        
        let childDelegates: [CascadingTableDelegate] = [
            DestinationHeaderSectionDelegate(viewModel: viewModel),
           DestinationInfoMapSectionDelegate(viewModel: viewModel),
            DestinationInfoListSectionDelegate(viewModel: viewModel),
          //  DestinationReviewRatingSectionDelegate(viewModel: viewModel),
          //  DestinationReviewUserSectionDelegate(viewModel: viewModel)
        ]
        
        rootDelegate = CascadingRootTableDelegate(
            childDelegates: childDelegates,
            tableView: tableView
        )
    }
 
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
        refreshData()
    }
    
    fileprivate func configureRefreshControl() {
        
        refreshControl.addTarget(self, action: #selector(TestViewController.refreshData), for: .valueChanged)
        
        tableView.addSubview(refreshControl)
    }
    
    fileprivate func startRefreshControl() {
        
        tableView.showRefreshControl()
        
        refreshControl.layoutIfNeeded()
        refreshControl.beginRefreshing()
        refreshControl.isHidden = false
    }
    
   
    @objc fileprivate func refreshData() {
        
        viewModel.refreshData { [weak self] in
          //  self?.updateTitle()
            self?.stopRefreshControl()
        }
        
        if refreshControl.isRefreshing {
            return
        }
        
        startRefreshControl()
    }
    
    fileprivate func stopRefreshControl() {
        
        let delayTime = DispatchTime.now() + 1.5
        let dispatchQueue = DispatchQueue.global(qos: .userInitiated)
        
        dispatchQueue.asyncAfter(deadline: delayTime) {
            
            DispatchQueue.main.async(execute: {
                self.refreshControl.endRefreshing()
            })
        }
    }
    
    private func processResponse(withPlacemarks placemarks: [CLPlacemark]?, error: Error?) {
        // Update View
        // geocodeButton.isHidden = false
        //  activityIndicatorView.stopAnimating()
        
        if let error = error {
            print("Unable to Forward Geocode Address (\(error))")
            print("Unable to Find Location for Address")
            
        } else {
            var location: CLLocation?
            
            if let placemarks = placemarks, placemarks.count > 0 {
                location = placemarks.first?.location
            }
            
            if let location = location {
                let coordinate = location.coordinate
              viewModel.locationcode = CLLocationCoordinate2D(
                latitude: coordinate.latitude,
                    longitude: coordinate.longitude
                )
                print("\(coordinate.latitude), \(coordinate.longitude)")
            } else {
                print("No Matching Location Found")
            }
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
