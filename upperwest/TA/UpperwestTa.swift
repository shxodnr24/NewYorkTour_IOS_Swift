//
//  UpperwestTa.swift
//  NewYorkTour
//
//  Created by Taewook Noh on 2018. 3. 30..
//  Copyright © 2018년 taewook. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import CoreLocation
import GoogleMobileAds

protocol senddata :class{
    var locationaddress:String? {get}
}

class UpperwestTa: UIViewController , UITableViewDelegate, UITableViewDataSource{
    //lazy var geocoder = CLGeocoder()
    var handle:DatabaseHandle?
    var db = [UpperwestTaData]()
    lazy var geocoder = CLGeocoder()
    var banner:GADBannerView!
    var location:String?
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
         super.viewDidLoad()
        self.view.addSubview(activityIndicator)
      loadbanner()
      
         var ref: DatabaseReference!
        ref = Database.database().reference()
//        tableView.rowHeight = UITableViewAutomaticDimension
//        tableView.estimatedRowHeight = 120
        
       self.activityIndicator.startAnimating()
         handle = ref?.child("ta/UpperWest").observe(DataEventType.value, with: {(snapshot) in
            
            for ta in snapshot.children.allObjects as![DataSnapshot]
            {
                let ta1 = ta.value as? [String : AnyObject]
                let taID = ta1?["ID"]
                let placeID = ta1?["placeID"]
                let taLocation = ta1?["location"]
                let taInfo = ta1?["info"]
                let tahomepage = ta1?["site"]
                let openinghour = ta1?["OpeningHour"]
                
                let tadata = UpperwestTaData(id: taID as! String?, info: taInfo as! String?, location: taLocation as! String?, homepage: tahomepage as! String?, openingHour: openinghour as! [String:AnyObject], placeID: placeID as! String?)
                self.db.append(tadata)
                
            }
          
           
            
            DispatchQueue.global().async {
                for index in 1...100000{
               
                }
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.activityIndicator.stopAnimating()
                self.activityIndicator.hidesWhenStopped = true
            }
            
         })
        
       

        // Do any additional setup after loading the view.
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return db.count
    }
    

   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let tadata : UpperwestTaData
        tadata = db[indexPath.row]
        self.location = tadata.location
        geocode(data: tadata.location!)
        print("이거도 볼수 있나욤?", tadata.location!)
        print("이거는 언제 볼수 있음?", location!)
       
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "upperwestta", for: indexPath) as! UpperwestTaCell
       
        let tourlist : UpperwestTaData
        tourlist = db[indexPath.row]
     
        
      
        cell.IDcell.text = tourlist.id
        cell.LocationCell.text = tourlist.location
        cell.loadfirstImage(placeid: tourlist.placeID!)
        
        return cell
        
    }
    
    func sendLocation(seletedlocation:String) {
        self.location = seletedlocation
     
    }
    
    func sendData(data:String?) -> String {
      
        return data!
    }
    
    func geocode(data:String) {
        geocoder.geocodeAddressString(data) {
            (CLPlacemark, error) in
            self.processResponse(withPlacemarks: CLPlacemark, error: error)
        }
    }
    
    private func processResponse(withPlacemarks placemarks: [CLPlacemark]?, error: Error?)  {
        // Update View
        // geocodeButton.isHidden = false
        //  activityIndicatorView.stopAnimating()
        print("이건 언제 불렸음?")
        if let error = error {
            print("Unable to Forward Geocode Address (\(error))")
            //  geoCodeCell.text = "Unable to Find Location for Address"
            
        } else {
            var location: CLLocation?
            
            if let placemarks = placemarks, placemarks.count > 0 {
                location = placemarks.first?.location
            }
            
            if let location = location {
                let coordinate = location.coordinate
                
                print("제대로 바뀐건가?", coordinate)
             
                
                
                // loca.latitude = coordinate.latitude
                // loca.longitude = coordinate.longitude
                // print("in function",loca)
                //loca(latitude: coordinate.latitude, longitude: coordinate.longitude)
                
                
                //                configure(latitude: coordinate.latitude, longtitude: coordinate.longitude, id:name!)
                //                geoCodeCell.text = "\(coordinate.latitude), \(coordinate.longitude)"
            } else {
                //                geoCodeCell.text = "No Matching Location Found"
            }
            //   print("in function2",loca)
        }
        //  print("in function3",loca)
        
    }

    
   
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //var geocode1 = CLLocationCoordinate2D()
        if segue.identifier == "upperwest"
        {
            let tadetail = segue.destination as! UpperWestTaDetail
             let selectedPath = self.tableView.indexPathForSelectedRow!
            
            let data : UpperwestTaData
            data = db[selectedPath.row]
          
           
         
           tadetail.taname = data.id
            tadetail.tainfo = data.info
            tadetail.talocation = data.location
            tadetail.tahomepage = data.homepage
            tadetail.openinghour = data.openingHour
            tadetail.placeID = data.placeID
            print(data.openingHour)
            
            
        }
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

extension UpperwestTa:senddata {
    
    var locationaddress: String? {
        return location
    }
    
}
