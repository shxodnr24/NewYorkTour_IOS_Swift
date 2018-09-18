//
//  GetWeather.swift
//  NewYorkTour
//
//  Created by Taewook Noh on 2018. 9. 17..
//  Copyright © 2018년 taewook. All rights reserved.
//

import Foundation
import AVFoundation

class GetWeather {
    static var shread: GetWeather = GetWeather()
    var synth = AVSpeechSynthesizer()
    var utterance = AVSpeechUtterance(string: "")
    var temp:Double?
    let openWeatherMapBaseURL = "https://api.openweathermap.org/data/2.5/weather"
    let openWeatherMapAPIKey = "Put your API KEY"
    
    //"APPID=e33357cbab470f07510ff10a287949e1"
    
    
    func getWeather() {
       // var test2 = ""
        var test2:URL?
        let session = URLSession.shared
        let urlString2 = openWeatherMapBaseURL + "?APPID=" + openWeatherMapAPIKey + "&q=New York,US"
        //let urlString = "\(openWeatherMapBaseURL)?APPID=\(openWeatherMapAPIKey)&q=New York,US)
        let weatherRequestURL = URL(string: "\(openWeatherMapBaseURL)?APPID=\(openWeatherMapAPIKey)&q=New York,US")
       
        if let encoded  = urlString2.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed),
            let myURL = URL(string: encoded){
            test2 = myURL
          //  test2 = myURL
            print(myURL)
            print(test2!)
         
            
        }
        
        print("이거 값은?" , test2!)
     
        
        
      
     
        
        let dataTask = session.dataTask(with: test2!, completionHandler: { (data, response, error) in
            
            if let error = error {
                print("Error:\n\(error)")
            } else {
                do {
                    let weather = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String:AnyObject]
                    self.temp = (weather["main"]!["temp"]!! as! Double - 273.14)
                    self.utterance = AVSpeechUtterance(string: "Weather data for \(weather["name"]!): It is \((weather["weather"]![0]! as! [String: AnyObject])["main"]!) outside. The temperature is \(weather["main"]!["temp"]!! as! Double - 273.14) Celcius. The Humidity is \(weather["main"]!["humidity"]!!) percent. The pressure is \(weather["main"]!["pressure"]!!) hpa. ")
                    self.utterance.rate = 0.4
                    self.synth.speak(self.utterance)
                   
                    
                }
                catch let jsonError as NSError {
                    print("JSON error: \(jsonError.description)")
            }
            
            }
            
           
        })
        dataTask.resume()
        
        
    }
}
