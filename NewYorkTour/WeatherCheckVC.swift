//
//  WeatherCheckVC.swift
//  NewYorkTour
//
//  Created by Taewook Noh on 2018. 9. 14..
//  Copyright © 2018년 taewook. All rights reserved.
//

import UIKit
struct mainstruct:Codable {
    
    struct main: Codable {
        var temp:Float?
        var humidity:Int?
        var temp_min:Float?
        var temp_max:Float?
    }
    
    struct weather:Codable {
        var main:String?
        var icon:String?
    }
    
    var maindata:main
    var weatherData:weather
    
    
}

struct ServerResponse : Codable {
    var temp:Float?
    var humidity:Int?
    var temp_min:Float?
    var temp_max:Float?
    var main:String?
    var icon:String?
    
    init(from decoder: Decoder) throws{
        let rawResponse = try mainstruct(from: decoder)
        temp = rawResponse.maindata.temp
        temp_max = rawResponse.maindata.temp_max
        temp_min = rawResponse.maindata.temp_min
        humidity = rawResponse.maindata.humidity
        icon = rawResponse.weatherData.icon
        main = rawResponse.weatherData.main
        
    }
    
}

class WeatherCheckVC: UIViewController {
   
   
    @IBOutlet weak var text1: UILabel!
    override func viewDidLoad() {
         super.viewDidLoad()
        
    let weatherGetter = GetWeather()
       print("하하", weatherGetter.getWeather())
      
            
        GetWeather.shread.getWeather() { (ok, data, error) in
            
            
        }
     
       
   
    
        }

    
        // Do any additional setup after loading the view.

    
    func test() {
     
   
       // print(url)
        print("asdfsadf")
      //  var request = URLRequest(url: url)
        
     //   request.httpMethod = "GET"
        
     
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
    /*
 
 if let data = data {
 let Arr = try! JSONSerialization.jsonObject(with: data, options: []) as! [String:Any]
 let name = Arr["name"]
 let temp = ((Arr["main"] as! [String:Any])["temp"] as! Float)-273
 let maxTemp = ((Arr["main"] as! [String:Any])["temp_max"] as! Float)-273
 let minTemp = ((Arr["main"] as! [String:Any])["temp_min"] as! Float)-273
 print(minTemp)
 let icon = (Arr["weather"] as! [[String: Any]])[0]["icon"]
 var returnDic = ["name":name,
 "temp":temp,
 "icon":icon,
 "maxTemp":maxTemp,
 "minTemp":minTemp]
 print(returnDic)
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


