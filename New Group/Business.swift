//
//  Business.swift
//  Business
//


import UIKit
import MapKit
import CoreLocation

class Business: NSObject, MKAnnotation {
    let name: String
    let id: String
    let location: Location
    let coordinates: CLLocation
    let distance: String?
    let rating: Double
    let reviewCount: Int
    let imageUrl: String
    let price:String
    let url: String
    let isClosed: Bool?
    let displayPhone: String?
    var reviews: [Review] = []
    
    //MKAnnotation things
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    
    init(name: String, id: String, location: Location, coordinates: CLLocation, distance:String, rating: Double, price:String, reviewCount: Int, imageUrl: String, url:String, isClosed:Bool, displayPhone:String) {
        self.name = name
        self.id = id
        self.location = location
        self.price = price
        self.coordinates = coordinates
        self.rating = rating
        self.reviewCount = reviewCount
        self.imageUrl = imageUrl
        self.url = url
        self.isClosed = isClosed
        self.displayPhone = displayPhone
        
        self.coordinate = CLLocationCoordinate2D(latitude: coordinates.coordinate.latitude, longitude: coordinates.coordinate.longitude)
        self.title = name
        
        let address = "\(location.address1), \(location.city), \(location.state) \(location.zipCode)"
        
        self.subtitle = address
        self.distance = distance
        super.init()
    }
    
    func loadImage(from url: String) {
        print(url)
    }
    
    static func fromDictionary(dictionary: NSDictionary) -> Business? {
        
        //Pull out each individual element from the dictionary
        guard let name = dictionary["name"] as? String,
            let id = dictionary["id"] as? String,
            let rating = dictionary["rating"] as? Double,
            let reviewCount = dictionary["review_count"] as? Int,
            let imageUrl = dictionary["image_url"] as? String,
            let url = dictionary["url"] as? String
  
            else {
                print("Error creating object from dictionary")
                return nil
        }
        
//        var imageURL:URL?
//        let imageURLString = dictionary["image_url"] as? String
//        if imageURLString != nil {
//            imageURL = URL(string: imageURLString!)!
//        } else {
//            imageURL = nil
//        }
        
       let isClosed = dictionary["is_closed"] as? Bool
        let displayPhone = dictionary["display_phone"] as? String
        //create location
        guard let locationDictionary = dictionary["location"] as? NSDictionary else { return nil }
        guard let locationObject = Location.fromDictionary(dictionary: locationDictionary) else {return nil}
        
        //create coordinates
        guard let coordinatesDictionary = dictionary["coordinates"] as? NSDictionary else { return nil }
        guard let latitude = coordinatesDictionary["latitude"] as? CLLocationDegrees else { return nil }
        guard let longitude = coordinatesDictionary["longitude"] as? CLLocationDegrees else { return nil  }
        let coordinatesObject = CLLocation(latitude: latitude , longitude: longitude)
        let distanceMeters = dictionary["distance"] as? NSNumber
        var distance:String?
        if distanceMeters != nil {
            let milesPerMeter = 0.000621371
            distance = String(format: "%.2f mi", milesPerMeter * distanceMeters!.doubleValue)
        } else {
            distance = nil
        }
        var price:String?
      let pricedetail = dictionary["price"] as? String
        
        if pricedetail != nil {
            price = pricedetail
        } else {
            price = "NIF"
        }
        
        //Take the data parsed and create a Place Object from it
        return Business(name: name, id: id, location: locationObject, coordinates: coordinatesObject, distance: distance!, rating: rating, price:price!, reviewCount: reviewCount, imageUrl: imageUrl, url: url, isClosed: isClosed!, displayPhone: displayPhone!)
    }
    
    static func getImage(from url: String) -> UIImage? {
        
        guard let imageUrl = URL(string: url) else { return nil  }
        
        do {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            let imageData = try Data(contentsOf: imageUrl)
            
            guard let image = UIImage(data: imageData) else { return nil }
            return image
        } catch {
            print("Could not create an image out of provided link")
        }
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        return nil
    }
    
    static func getImageAsync(from url: String, completionHandler: @escaping (UIImage) -> ()) {
        
        guard let imageUrl = URL(string: url) else { return  }
        
        do {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            let imageData = try Data(contentsOf: imageUrl)
            
            guard let image = UIImage(data: imageData) else { return }
            //return image
            completionHandler(image)
        } catch {
            print("Could not create an image out of provided link")
        }
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        return
    }
    
    static func getRatingImage(rating: Double) -> String {
        
        switch rating {
        case 5:
            return "rating50"
        case 4.5:
            return "rating45"
        case 4:
            return "rating40"
        case 3.5:
            return "rating35"
        case 3:
            return "rating30"
        case 2.5:
            return "rating25"
        case 2:
            return "rating20"
        case 1.5:
            return "rating15"
        case 1:
            return "rating10"
        default:
            return "rating0"
        }
    }
    
    func getReviews(completionHandler: @escaping ([Review]) -> ()) {
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        print("➡️ Getting reviews for business \(self.name)")
        
        var arrayOfReviews: [Review] = []
        let yelpAPI = "press your API KEY"
        //        let accessToken = valueForAPIKey(named: "YELP_API_ACCESS_TOKEN")
        
        let link = "https://api.yelp.com/v3/businesses/\(self.id)/reviews"
        
        //set headers
        let headers = [
            "Authorization": "Bearer \(yelpAPI)"
        ]
        
        guard let url = URL(string: link) else { return }
        
        //set request
        var request = URLRequest.init(url: url)
        
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        //        request.httpBody = bodyData.data(using: .utf8)
        
        
        //create sharedSession
        let sharedSession = URLSession.shared
        
        // setup completion handler
        let completionHandler: (Data?, URLResponse?, Error?) -> Void = { data, response, error in
            
            guard let data = data, error == nil else {
                // check for networking error
                print("error=\(error)")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
            }
            
            //let responseString = String(data: data, encoding: .utf8)
            //print("responseString = \(responseString)")
            
            do {
                let jsonObject = try JSONSerialization.jsonObject(with: data, options:
                    JSONSerialization.ReadingOptions.allowFragments)
                
                guard let result = jsonObject as? NSDictionary else { print("result is not a dictionary"); return }
                
                guard let reviews = result["reviews"] as? NSArray else { print("not review array present"); return }
                
                for reviewObject in reviews {
                    guard let reviewDictionary = reviewObject as? NSDictionary else { print("reviewDictionary is not a dictionary"); return }
                    
                    // create review object
                    guard let review = Review.fromDictionary(dictionary: reviewDictionary) else { print("can't create a review out of the data"); return }
                    
                    arrayOfReviews.append(review)
                    completionHandler(arrayOfReviews)
                    
                }
                
            } catch {
                print("Could not get reviews")
                return
            }
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }
        
        // set dataTask
        let dataTask = sharedSession.dataTask(with: request, completionHandler: completionHandler)
        
        //resume dataTask
        dataTask.resume()
        
        return
    }
    
    static func getLocalPlaces(forCategory category: String, coordinates: CLLocationCoordinate2D, completionHandler: @escaping ([Business]) -> ()) {
        
        //        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        var arrayOfBusinesses: [Business] = []
        let yelpAPI = "Put your API KEY"
        //        let accessToken = valueForAPIKey(named: "YELP_API_ACCESS_TOKEN")
        
        //if radius return 0 results then increase the radius
        let radius = 1000
        
        // limit distance and limit to open only.
        let link = "https://api.yelp.com/v3/businesses/search?categories=\(category)&latitude=\(coordinates.latitude)&longitude=\(coordinates.longitude)&radius=\(radius)" //&open_now=true
        
        //set headers
        let headers = [
            "Authorization": "Bearer \(yelpAPI)"
        ]
        
        guard let url = URL(string: link) else { return }
        
        //set request
        var request = URLRequest.init(url: url)
        
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        //        request.httpBody = bodyData.data(using: .utf8)
        
        
        //create sharedSession
        let sharedSession = URLSession.shared
        
        // setup completion handler
        let completionHandler: (Data?, URLResponse?, Error?) -> Void = { data, response, error in
            
            guard let data = data, error == nil else {
                // check for networking error
                print("error=\(error)")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
            }
            
            //let responseString = String(data: data, encoding: .utf8)
            //print("responseString = \(responseString)")
            
            do {
                let jsonObject = try JSONSerialization.jsonObject(with: data, options:
                    JSONSerialization.ReadingOptions.allowFragments)
                
                guard let result = jsonObject as? NSDictionary else { print("result is not a dictionary"); return }
                guard let total = result["total"] as? Int else { print("no total available"); return }
                guard total > 0 else { print("Search returned 0 results") ; return }
                guard let businesses = result["businesses"] as? NSArray else { print("business is not an array"); return }
                
                for businessObject in businesses {
                    guard let businessDictionary = businessObject as? NSDictionary else { print("businessDict is not a dictionary"); return }
                    
                    // create business object
                    guard let business = Business.fromDictionary(dictionary: businessDictionary) else { print("can't create a business out of the data"); return }
                    
                    arrayOfBusinesses.append(business)
                    completionHandler(arrayOfBusinesses)
                    
                }
                
                
                DispatchQueue.main.async {
                    // do something in the main queue
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    //                                                    self.dataContentText.text = jsonString
                }
                
            } catch {
                print("Could not get places")
                return
            }
            
        }
        
        // set dataTask
        let dataTask = sharedSession.dataTask(with: request, completionHandler: completionHandler)
        
        //resume dataTask
        dataTask.resume()
        
        return
        
    }
    
}
