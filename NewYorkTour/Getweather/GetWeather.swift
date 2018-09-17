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
    var synth = AVSpeechSynthesizer()
    var utterance = AVSpeechUtterance(string: "")
    let openWeatherMapBaseURL = "https://api.openweathermap.org/data/2.5/weather?q=New York,US"
    let openWeatherMapAPIKey = "e33357cbab470f07510ff10a287949e1"
    
    //"APPID=e33357cbab470f07510ff10a287949e1"
    
    
    
}
