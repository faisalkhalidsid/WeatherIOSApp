//
//  Weather.swift
//  WeatherHBMSUDemo
//
//  Created by mac on 2018-08-01.
//  Copyright © 2018 faisalkhalid. All rights reserved.
//

import Foundation

class Weather {
    var location:WeatherLocation
    var current:WeatherCurrent
    var forecast:[WeatherForecast]?
    
    init(location:WeatherLocation,current:WeatherCurrent,forecast:[WeatherForecast]?) {
        self.location = location
        self.current = current
        self.forecast = forecast
    }
    
}
