//
//  WeatherCurrent.swift
//  WeatherHBMSUDemo
//
//  Created by mac on 2018-08-01.
//  Copyright © 2018 faisalkhalid. All rights reserved.
//

import Foundation

struct WeatherCurrent {

    var code:String
    var date:String
    var temperature:String
    var text:String
    var unit:WeatherUnit
    
    init(code:String,date:String,temperature:String,text:String,unit:WeatherUnit) {
        self.code = code
        self.date = date
        self.temperature = temperature
        self.text = text
        self.unit = unit
    }
}

enum WeatherUnit {
    case FAHRENHEIT,CELCIUS
}
