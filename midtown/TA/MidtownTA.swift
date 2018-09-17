//
//  MidtownTA.swift
//  NewYorkTour
//
//  Created by Taewook Noh on 2018. 3. 21..
//  Copyright © 2018년 taewook. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import GoogleMobileAds




class MidtownTA: UIViewController,  UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    var banner:GADBannerView!
    @IBOutlet weak var tableView: UITableView!
    var keys:[String] = []
    var handle:DatabaseHandle?
    var myList3: Array<DataSnapshot> = []
    var myList2:[String : AnyObject] = [:]
    var myList:[String] = []
    var testarray:[String] = []
    var myList4:[Any]!
    var db = [MidtownTAData]()
    
    var myList5:Dictionary<String, Int>!
    var test:DatabaseReference!
    override func viewDidLoad() {
        super.viewDidLoad()
        loadbanner()
   tableView.delegate = self
        tableView.dataSource = self
        
        print("test1" , keys)
         self.view.addSubview(indicatorView)
      
        var ref: DatabaseReference!
        test = ref?.child("ta/Midtown").child("")
      
        ref = Database.database().reference()
        
        handle = ref?.child("ta/Midtown").observe(DataEventType.value, with: {(snapshot) in
            
        for ta in snapshot.children.allObjects as![DataSnapshot]
        {
            let ta1 = ta.value as? [String : AnyObject]
            let taID = ta1?["ID"]
            let taInfo = ta1?["info"]
            let taLocation = ta1?["location"]
            
            let taHomepage = ta1?["site"]
            let openinghour = ta1?["OpeningHour"]
            let placeID = ta1?["PlaceID"]
            
            let tadata = MidtownTAData(id: taID as! String?, info: taInfo as! String?, location: taLocation as! String?, homepage: taHomepage as! String?, openinghour:openinghour as! [String:AnyObject], placeID: placeID as! String? )
            self.db.append(tadata)
            
        
          
            }
            
            self.indicatorView.startAnimating()
            DispatchQueue.global().async {
                for index in 1...100000{
                    print(index)
                }
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.indicatorView.stopAnimating()
                self.indicatorView.hidesWhenStopped = true
            }
           
            
        /*   if let postdic = snapshot.value as? [String : AnyObject]
           {
           self.myList3.append(snapshot)
          print("test contains",  self.myList3.description)
       
           // var keys : Array = Array(self.myList2.keys)
         self.myList2 = postdic
         if let test =   self.myList2["info"]
         {
            print("캬캬", test)
            }
          let keys1 = [String](self.myList2.keys)
          self.keys.append(keys1[0])
        self.keys.append(keys1[1])
            // print("test",self.myList2["name"] as! String)
          //  for key in keys
           // {
            //    print(key)
           // }
          print("keys", self.myList2.keys)
            print("myList2", self.myList2)
        //    print(self.myList2)
            
            print("myList", self.myList)
            print("test", keys1)
            print("Count",postdic.count)
          print("MyList3",self.myList3)
             self.tableView.reloadData()
          
            
            } */
        
        })
     
      
      
       /*handle = ref?.child("ta/Midtown/\(self.keys[0])").observe(.childAdded, with: {(snapshot) in
            
            if let postdic = snapshot.value as? [String : AnyObject]
            {
                
                self.myList2 = postdic
                print(self.myList2)
                
            }
            
            if let postdic2 = snapshot.value as? String
            
            {
                self.myList.append(postdic2)
                print("testtest", self.myList)
            }
            
        }) */
       
      
       /*let mytoplist = (ref.child("ta/Midtown")).queryOrdered(byChild: "Midtown").observe(.childAdded, with: {(snapshot) in
            if let postdic3 = snapshot.value as? String
                
            {
                self.myList.append(postdic3)
                print(self.myList)
            }
          
            
        })
        print(mytoplist) */
        // Do any additional setup after loading the view, typically from a nib.
    }
    
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
}
    
    //Admin Firebase DB acces code rea

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return db.count
        
    }
    
   

    
   /* func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    } */
 
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "midtownta", for: indexPath) as! MidtownTAcell
        
        let tourlist : MidtownTAData
        tourlist = db[indexPath.row]
       
        do {
            try cell.loadfirstImage(placeid: tourlist.placeID!)
        } catch {
            print("에러가 발생했습니다.")
        }
        
        cell.nameCell.text = tourlist.id
        //cell.infoCell.text = tourlist.info
        cell.addressCell.text = tourlist.location
       
       
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

//Throw to MidtownTAdetail
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "tadetail"
        {
            let move = segue.destination as! MidtownTADetail2
            let myIndexPath = self.tableView.indexPathForSelectedRow!
          
            
            let data : MidtownTAData
            data = db[myIndexPath.row]
            
            move.taname = data.id
            move.tainfo = data.info
            move.talocation = data.location
            move.tahomepage = data.homepage
            move.openinghour = data.openinghour
            move.placeID = data.placeID
          //  move.locationCell.text = data.location
          
        }
    }
    
    
    
    
  
    
}
