//
//  TAinfomap.swift
//  NewYorkTour
//
//  Created by Taewook Noh on 2018. 5. 8..
//  Copyright © 2018년 taewook. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import Contacts




class TAinfomap: UITableViewCell, MKMapViewDelegate {

    fileprivate var latestCoordinate: CLLocationCoordinate2D?
    fileprivate var latestRegionDistance: Double?
    var cordi:CLLocationCoordinate2D?
    var addressString:String?
    var homepage:String?
    var locationdata:String?
    var op :[String:String] = [:]
    var db = [TAinfomapData]()
    
  //  var address:String?
    
    @IBOutlet weak var mapView: MKMapView!
  override func awakeFromNib() {
        super.awakeFromNib()
   
    
   mapView.delegate = self
    print("is it right?", latestCoordinate as Any)
    
        // Initialization code
    }
    func getData(data:[String:String]) {
        op = data
        
    }
   
    
    func getPostalString(data:CLLocationCoordinate2D, name:String, homepage:String) ->[String:String]{

        var addressdata:[String:String]



            var addressdata2 : [String: String] = [:]
        let newLocation = CLLocation(latitude: data.latitude, longitude: data.longitude)
        CLGeocoder().reverseGeocodeLocation(newLocation, completionHandler: {(placemarks, error) in
            if error != nil {
                print("Geocode failed with error: \(error!.localizedDescription)")
            }

            if let marks = placemarks, marks.count > 0 {
                let placemark = marks[0]
                let postalAddress = placemark.postalAddress

                var test:[String:String] = [:]
                if let address = postalAddress?.street,
                    let test1 = postalAddress?.subAdministrativeArea,
                    let city = postalAddress?.city,
                    let state = postalAddress?.state,
                    let zip = postalAddress?.postalCode {

//                    addressdata = [CNPostalAddressStreetKey: address,
//                                  CNPostalAddressCityKey: city,
//                                  CNPostalAddressStateKey: state,
//                                  CNPostalAddressPostalCodeKey: zip,
//                                  CNPostalAddressISOCountryCodeKey: "US"]

                    let address1 = [CNPostalAddressStreetKey: address,
                                   CNPostalAddressCityKey: city,
                                   CNPostalAddressStateKey: state,
                                   CNPostalAddressPostalCodeKey: zip,
                                   CNPostalAddressISOCountryCodeKey: "US"]
                    var placemarker : MKPlacemark = MKPlacemark(coordinate: data, addressDictionary: address1)
                    let mapItem = MKMapItem(placemark: placemarker)
                    mapItem.name = name
                    let regionSpan = MKCoordinateRegionMakeWithDistance(data, 500, 500)
                    
                    let options = [
                        
                        MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
                        MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
                    ]
                    mapItem.url = URL(string: homepage)
                    mapItem.openInMaps(launchOptions: options)
                    
                    test = address1
                    let addressdata = TAinfomapData(data: test as [String:String])
                    self.db.append(addressdata)
                    addressdata2 = address1
                 print("in the Scope(ßtest)", test)

                }
                print("this is out scope(test)", test)
            }
        })
            print("Check this out", op)
            print("Check this out(haha)", addressdata2)
       return addressdata2

    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        print("이거 호출됨?")
          print("하하하 이거는 값은?", self.op)
        //let data = CNPostalAddress(coder: locationdata)
     //   let postalString = CNPostalAddress.localizedString(forKey: <#T##String#>)
     
        //print("이거 값 나오나요?" , getPostalString(data: self.cordi!))
     
//        if let address = locationdata as? CNPostalAddress {
//            let city = address.city
//            let street = address.street
//
//        }
        if selected == true {
          
//            print("이거 값 나오나요?" , getPostalString(data: self.cordi!))
         
           
//      let alert = UIAlertController(title: "Homepage Moving", message: "눌렀네요", preferredStyle: UIAlertControllerStyle.alert)
//        alert.addAction(UIAlertAction(title: "cancel", style: .cancel, handler: nil))
//        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
//            let data : TAinfomapData
//            data = self.db[0]
//            var placemarker : MKPlacemark = MKPlacemark(coordinate: data, addressDictionary: data.data)
//            let mapItem = MKMapItem(placemark: placemarker)
//          print("이거 값은 나오나요?" , self.cordi)
//
//
//            print("하 드뎌야 값 나오나요?", data.data)
//            mapItem.name = self.addressString
//
//            mapItem.url = URL(string: self.homepage!)
//            mapItem.openInMaps(launchOptions: nil)
//            }))
//       UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
        }
        // Configure the view for the selected state
    }
   
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
      
        
        print("it is touched")
    }
 
    func configure(coordinate: CLLocationCoordinate2D, regionDistance: Double = 300.0) {
        
        let identicalCoordinate = (latestCoordinate?.latitude == coordinate.latitude) &&
            (latestCoordinate?.longitude == coordinate.longitude)
//        getPostalString(data: coordinate)
      
        let identicalDistance = (latestRegionDistance == regionDistance)
        
        if identicalDistance && identicalCoordinate {
            return
        }
        
        var placemarker : MKPlacemark = MKPlacemark(coordinate: coordinate, addressDictionary: nil)
        let newRegion = MKCoordinateRegionMakeWithDistance(coordinate, regionDistance, regionDistance)
        
        mapView.setRegion(newRegion, animated: false)
       let annotation = MKPointAnnotation()
//        func openmapss() {
//        let newLocation = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
//        CLGeocoder().reverseGeocodeLocation(newLocation, completionHandler: {(placemarks, error) in
//            if error != nil {
//                print("Geocode failed with error: \(error!.localizedDescription)")
//            }
//
//            if let marks = placemarks, marks.count > 0 {
//                let placemark = marks[0]
//                let postalAddress = placemark.postalAddress
//
//                var test:[String:String] = [:]
//                if let address = postalAddress?.street,
//                    let test1 = postalAddress?.subAdministrativeArea,
//                    let city = postalAddress?.city,
//                    let state = postalAddress?.state,
//                    let zip = postalAddress?.postalCode {
//
//                    //                    addressdata = [CNPostalAddressStreetKey: address,
//                    //                                  CNPostalAddressCityKey: city,
//                    //                                  CNPostalAddressStateKey: state,
//                    //                                  CNPostalAddressPostalCodeKey: zip,
//                    //                                  CNPostalAddressISOCountryCodeKey: "US"]
//
//                    let address1 = [CNPostalAddressStreetKey: address,
//                                    CNPostalAddressCityKey: city,
//                                    CNPostalAddressStateKey: state,
//                                    CNPostalAddressPostalCodeKey: zip,
//                                    CNPostalAddressISOCountryCodeKey: "US"]
//
//
//                    test = address1
//                    let addressdata = TAinfomapData(data: test as [String:String])
//                    self.db.append(addressdata)
//
//                    var placemarker : MKPlacemark = MKPlacemark(coordinate: coordinate, addressDictionary: address1)
//                    let mapItem = MKMapItem(placemark: placemarker)
//                    print("이거 값은 나오나요?" , self.cordi)
//
//
//
//                    mapItem.name = self.addressString
//
//                    mapItem.url = URL(string: self.homepage!)
//                    mapItem.openInMaps(launchOptions: nil)
//
//                    print("in the Scope(ßtest)", test)
//
//                }
//                print("this is out scope(test)", test)
//            }
//        })
//        }
        
        
        
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: newRegion.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: newRegion.span)
        ]
        annotation.coordinate = coordinate
        annotation.title = addressString
        annotation.subtitle = "hello2"
        mapView.addAnnotation(annotation)
        
//    let mapItem = MKMapItem(placemark: placemarker)
//        if mapItem.
//      mapItem.name = "\(self.addressString!)"
//      mapItem.openInMaps(launchOptions: options)
        latestCoordinate = coordinate
        latestRegionDistance = regionDistance
    }
    


    

}
