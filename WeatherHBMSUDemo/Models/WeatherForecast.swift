//
//  WeatherForcast.swift
//  WeatherHBMSUDemo
//
//  Created by mac on 2018-08-01.
//  Copyright © 2018 faisalkhalid. All rights reserved.
//

import Foundation

struct WeatherForecast {
    
    /*
     code: "34",
     date: "01 Aug 2018",
     day: "Wed",
     high: "93",
     low: "87",
     text: "Mostly Sunny"
 */
    
    var code:String
    var date:String
    var day:String
    var temp:String
    var high:String
    var low:String
    var text:String
    var unit:WeatherUnit

    init(code:String,date:String,day:String,high:String,low:String,text:String,unit:WeatherUnit) {
        self.code = code
        self.date = date
        self.day = day
        self.high = high
        self.low = low
        self.text = text
        self.unit = unit
        self.temp = "\(Int((Int(high)! + Int (low)!)/2))"
        
        
    }
    
   static func inCelcius(temp:String)->String{
        return "\(Int((Double(temp)! - 31) * ( 0.5556 )))"
    }
    
}
