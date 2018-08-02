//
//  Location.swift
//  WeatherHBMSUDemo
//
//  Created by mac on 2018-08-01.
//  Copyright © 2018 faisalkhalid. All rights reserved.
//

import Foundation

struct WeatherLocation {
    var country:String
    var region:String
    var city:String
    init(country:String,region:String,city:String) {
       self.country = country
        self.city = city
        self.region = region
    }
}
