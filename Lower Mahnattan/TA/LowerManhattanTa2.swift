//
//  LowerManhattanTa2.swift
//  NewYorkTour
//
//  Created by Taewook Noh on 2018. 5. 17..
//  Copyright © 2018년 taewook. All rights reserved.
//

import UIKit
import Firebase
import GoogleMobileAds

class LowerManhattanTa2: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var banner: GADBannerView!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    var handle:DatabaseHandle?
    var db = [UpperwestTaData]()
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        loadbanner()
       var ref: DatabaseReference!
          ref = Database.database().reference()
        self.view.addSubview(indicatorView)
        handle = ref?.child("ta/lower manhattan").observe(DataEventType.value, with: {(snapshot) in
             self.indicatorView.startAnimating()
            for ta in snapshot.children.allObjects as![DataSnapshot]
            {
                let ta1 = ta.value as? [String : AnyObject]
                let taID = ta1?["ID"]
                let taImageURL = ta1?["imageURL"]
                let taLocation = ta1?["location"]
                let taInfo = ta1?["info"]
                let tahomepage = ta1?["site"]
                let openinghour = ta1?["OpeningHour"]
                let placeID = ta1?["placeID"]
                
                let tadata = UpperwestTaData(id: taID as! String?, info: taInfo as! String?, location: taLocation as! String?, homepage: tahomepage as! String?, openingHour: openinghour as! [String:AnyObject], placeID: placeID as! String?)
                self.db.append(tadata)
                
            }
            
           
            
            DispatchQueue.global().async {
                for index in 1...100000{
                    print(index)
                }
            }
            DispatchQueue.main.async{
                 self.tableView.reloadData()
                self.indicatorView.stopAnimating()
                self.indicatorView.hidesWhenStopped = true
            }
            
        })
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return db.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tacell", for: indexPath) as! LowerManhattanTaCell2
        
        let tourlist : UpperwestTaData
        tourlist = db[indexPath.row]
      
        
        cell.loadfirstImage(placeid: tourlist.placeID!)
        cell.nameCell.text = tourlist.id
    
        cell.locationCell.text = tourlist.location
       
        
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
        if segue.identifier == "movetodetail" {
            let move = segue.destination as! LowerManhattanTaDetail
            let myIndexPath = self.tableView.indexPathForSelectedRow!
            
            let data : UpperwestTaData
            
            
            data = db[myIndexPath.row]
            
            move.taname = data.id
            move.tainfo = data.info
            move.talocation = data.location
            move.tahomepage = data.homepage
            move.openinghour = data.openingHour
            move.placeID = data.placeID

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
