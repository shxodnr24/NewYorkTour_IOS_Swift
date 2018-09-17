//
//  UppereastRestaurant.swift
//  NewYorkTour
//
//  Created by Taewook Noh on 2018. 4. 11..
//  Copyright © 2018년 taewook. All rights reserved.
//

import UIKit
import Firebase
import GoogleMobileAds

class UpperEastTouristAttraction: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    var banner:GADBannerView!
    var handle:DatabaseHandle?
    var db = [UpperEastTouristAttractionData]()
    var test1:String?
    var test2:String?
    var topPhoto1 = UIImage(named: "IMG_6650.JPG")
    var refreshControl = UIRefreshControl()
    
//    var headerSectionObservers = [DestinationHeaderSectionViewModelObserver]()
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    
    override func viewDidLoad() {
      
        super.viewDidLoad()
        loadbanner()
        self.view.addSubview(indicatorView)
        indicatorView.startAnimating()
        tableView.delegate = self
        tableView.dataSource = self
        var ref: DatabaseReference!
        ref = Database.database().reference()
       
        handle = ref?.child("ta/UpperEast").observe(DataEventType.value, with: {(snapshot) in
            
            for ta in snapshot.children.allObjects as![DataSnapshot]
            {
                let ta1 = ta.value as? [String : AnyObject]
                let taID = ta1?["ID"]
                let placeID = ta1?["placeID"]
                let taLocation = ta1?["location"]
                let taInfo = ta1?["info"]
                let tahomepage = ta1?["site"]
                let openinghour = ta1?["OpeningHour"]
                
                let tadata = UpperEastTouristAttractionData(id: taID as! String?, info: taInfo as! String?, location: taLocation as! String?, homepage: tahomepage as! String?, openingHour: openinghour as! [String:AnyObject], placeID: placeID as! String?)
                self.db.append(tadata)
                
            }
           // self.tableView.reloadData()
//            self.refreshControl.addTarget(self, action: #selector(UpperEastTouristAttraction.refreshData), for: UIControlEvents.valueChanged)
            
            DispatchQueue.global().async {
                for index in 1...100000{
                   // print(index)
                }
            }
            DispatchQueue.main.async {
                
                self.tableView.reloadData()
                self.indicatorView.stopAnimating()
                self.indicatorView.hidesWhenStopped = true
            }
            //self.tableView.reloadData()
            //self.spinni.stopAnimating()
        })

        
       
        
//        if #available(iOS 10.0, *) {
//            tableView.refreshControl = refreshControl
//        }else {
//            tableView.addSubview(refreshControl)
//        }
       // configureRefreshControl()
        // Do any additional setup after loading the view.
    }
//
//    @objc func refreshData() {
//        tableView.reloadData()
//
//        refreshControl.endRefreshing()
//    }
//
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return db.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "restaurantCell", for: indexPath) as! UpperEastTouristAttractionCell
        
        let tourlist : UpperEastTouristAttractionData
        tourlist = db[indexPath.row]
       
        
        cell.loadfirstImage(placeid: tourlist.placeID!)
        cell.nameCell.text = tourlist.id
        cell.addressCell.text = tourlist.location
        //cell.InfoCell.text = tourlist.info
      //  cell.LocationCell.text = tourlist.location
        
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
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

    
    //TestViewController에 값 전달
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "taDetail"
            
        {
            let move = segue.destination as! UpperEastTAdetail
            let selectedPath = self.tableView.indexPathForSelectedRow!
            let data : UpperEastTouristAttractionData!
            data = db[selectedPath.row]
           
            move.taname = data.id
            move.tainfo = data.info
            move.talocation = data.location
            move.tahomepage = data.homepage
            move.openinghour = data.openingHour
            move.placeID = data.placeID
            
      
            
      /*detailVC.address
            move.test = data.id
            move.location = data.location
            move.info = data.info */
            
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



