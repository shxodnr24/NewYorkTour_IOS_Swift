//
//  MidtownTADetail2.swift
//  NewYorkTour
//
//  Created by Taewook Noh on 2018. 5. 14..
//  Copyright © 2018년 taewook. All rights reserved.
//

import UIKit
import CoreLocation

class MidtownTADetail2: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
    @IBOutlet weak var tableView: UITableView!
    var taname:String?
    var tainfo:String?
    var talocation:String?
    var tahomepage:String?
    var openinghour = [String:AnyObject]()
    var placeID:String?
    let sectionTitle = ["name", "information"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
      

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getCoordinate( addressString : String,
                        completionHandler: @escaping(CLLocationCoordinate2D, NSError?) -> Void ) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(addressString) { (placemarks, error) in
            if error == nil {
                if let placemark = placemarks?[0] {
                    let location = placemark.location!
                    
                    completionHandler(location.coordinate, nil)
                    return
                }
            }
            
            completionHandler(kCLLocationCoordinate2DInvalid, error as NSError?)
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1
        {
            if indexPath.row == 0 {
                 let cell = tableView.dequeueReusableCell(withIdentifier: "tamap", for: indexPath) as! TAinfomap
                
                let alert = UIAlertController(title: "Apple maps", message: "Do you want to open Apple maps?", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "cancel", style: .cancel, handler: nil))
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                    self.getCoordinate(addressString: self.talocation!, completionHandler: {(data,nil) in
                        cell.getPostalString(data: data, name:self.taname!, homepage:self.tahomepage!)
                         cell.homepage = self.tahomepage
//                        cell.configure(coordinate: data)
                    })
                    
                    
                }))
                present(alert, animated: true, completion:nil )
            }
            else if indexPath.row == 2
            {
                
                
                let alert = UIAlertController(title: "Homepage Moving", message: "homepage Moving", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "cancel", style: .cancel, handler: nil))
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                    UIApplication.shared.open(URL(string: self.tahomepage!)! as URL, options: [:], completionHandler: nil)
                    
                    
                }))
                present(alert, animated: true, completion:nil )
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return sectionTitle[0] }
        else
        {
            return sectionTitle[1]
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 3
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0{
            return 3
        }else {
            return 4
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0
        {
            
            if indexPath.row == 0{
                let cell = tableView.dequeueReusableCell(withIdentifier: "namecell", for: indexPath) as! TAnamecell
                cell.taname.text = taname
                cell.subjectCell.text = "Tourist Attraction"
                
                return cell
            }
            else if indexPath.row == 1 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "imagecell", for: indexPath) as! TAnameInfoImageCell
               cell.loadfirstImage(placeid: placeID!)
                return cell
                
            }
                
            else if indexPath.row == 2 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "tainfodetail", for: indexPath) as! TAinfocell
                cell.tainfoLabel.text = tainfo
                
                return cell
                
            }
                
            else {
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "namecell", for: indexPath) as! TAnamecell
                cell.taname.text = taname
                return cell
                
            }
            
            
            /*  let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
             cell.textLabel?.text = object[indexPath.section].belong[indexPath.row]
             
             return cell */
        } else{
            
            if indexPath.row == 0
            {
                let cell = tableView.dequeueReusableCell(withIdentifier: "tamap", for: indexPath) as! TAinfomap
             
                // var data123 = CLLocationCoordinate2D()
                
                getCoordinate(addressString: talocation!, completionHandler: {(data,nil) in
                    cell.cordi = data
                    cell.configure(coordinate: data)
                   
                })
                cell.addressString = taname
                cell.homepage = tahomepage
                // print("이거는 된건가?", data123)
                //   cell.configure(coordinate: data123)
                //  cell.address = talocation
                //cell.configure(coordinate: CLLocationCoordinate2D)
                return cell
            }
            else if indexPath.row == 1 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "tadetailcell01", for: indexPath) as! UppperwestTADetailCell
                cell.namecel.text = "Location"
                cell.descriptioncell.text = talocation
                
                return cell
                
                
                
            }else if indexPath.row == 2 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "taurlcell", for: indexPath) as! UpperwestTAurlCell
                cell.nameCell.text = "Homepage"
                cell.urlButton.setTitle(tahomepage, for: UIControlState.normal)
               
                
                return cell
                
            }
            
            else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "openinghour", for: indexPath) as! TAinfoOpeningHour
                cell.nameCell.text = "Opening Hour"
                for (mykey, value) in openinghour{
                    if(mykey == "Sat")
                    {
                        cell.satCell.text = value as? String
                    }
                    else if(mykey == "Sun")
                    {
                        cell.sunCell.text = value as? String
                    }
                    else if(mykey == "Mon")
                    {
                        cell.monCell.text = value as? String
                    }
                    else if(mykey == "Tue")
                    {
                        cell.tueCell.text = value as? String
                    }
                    else if(mykey == "Wed")
                    {
                        cell.wedCell.text = value as? String
                    }
                    else if(mykey == "Thur")
                    {
                        cell.thuCell.text = value as? String
                    }
                    else
                    {
                        cell.friCell.text = value as? String
                    }
                    print("\(mykey) \t \(value)")
                }
                //   cell.urlCell.text = tahomepage
                
                return cell
                
                
            }
            
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
