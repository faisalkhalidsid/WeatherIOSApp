//
//  WeatherClient.swift
//  WeatherHBMSUDemo
//
//  Created by mac on 2018-08-01.
//  Copyright © 2018 faisalkhalid. All rights reserved.
//

import Foundation
import NetworkExtension
import CoreLocation
import UIKit
class WeatherClient {
    
    var baseURL = "https://query.yahooapis.com/v1/public/yql?"
    var session = URLSession.shared

     func getWeatherByLatLong(cordinate:CLLocationCoordinate2D,completionHandler:@escaping (_ error:Error?,_ data:Weather?)->Void){

        let url = URL(string: "\(baseURL)q=select+%2A+from+weather.forecast+where+woeid+in+%28SELECT+woeid+FROM+geo.places+WHERE+text%3D%22%28\(cordinate.latitude)%2C\(cordinate.longitude)%29%22%29%0D%0A&format=json")
        
        var request = NSMutableURLRequest(url: url!, cachePolicy:
            NSURLRequest.CachePolicy.reloadIgnoringLocalAndRemoteCacheData,
                                          timeoutInterval: 30.0)
        
        request.httpMethod = "GET"
        
        let task = session.dataTask(with: request as URLRequest, completionHandler: {
            data, response, error in
            
            if let error = error {
                print(error.localizedDescription)
                completionHandler(error,nil)
            }
            
            
            if let data = data {
                
                do {
                    let string1 = String(data: data, encoding: String.Encoding.utf8) ?? "Data could not be printed"
           //         print(string1)
                    
                  var json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String:Any]
                    if let query = json["query"] as? [String:Any] {
                        if let count = query["count"] as? Int {
                            
                            if count == 1 {
                                
                                
                                var currentCondition:WeatherCurrent?
                                var forecast:[WeatherForecast] = []
                                var location:WeatherLocation?
                                
                                
                                
                                if let results = query["results"] as? [String:Any] {
                              //     print(results)
                                    if let channel = results["channel"] as? [String:Any] {
                                    if let loc = channel["location"] as? [String:String] {
                                         location = WeatherLocation.init(country: loc["country"]!, region: loc["region"]!, city: loc["city"]!)
                                    
                                    }
                                        
                                        if let item = channel["item"] as? [String:Any] {
                                        
                                          //  print(item)
                                            
                                            if  let condition = item["condition"] as? [String:String] {
                                                
                                                 currentCondition = WeatherCurrent.init(code: condition["code"]!, date: condition["date"]!, temperature: condition["temp"]!, text: condition["text"]!, unit:.FAHRENHEIT)
                                               // print(currentCondition)
                                            }
                                            
                                            
                                            if let forecastList = item["forecast"]  as? [[String:Any]] {
                                                
                                                for item in forecastList {
                                                
                                                    var forecastObj = item as! [String:String]
                                                
                                                      forecast.append(WeatherForecast.init(code: forecastObj["code"]!, date: forecastObj["date"]!, day: forecastObj["day"]!, high: forecastObj["high"]!, low: forecastObj["low"]!, text: forecastObj["text"]!, unit: .FAHRENHEIT))
                                                    
                                                }
                                                
                                            }
                                        }
                                    }
                                    
                                }
        
                                completionHandler(nil,Weather.init(location: location!, current: currentCondition!, forecast: forecast))
                            }
                        }
                    }
         
                    
                    
                }
                catch {
                    
                    
                    let error = NSError(domain:"", code:401, userInfo:[ NSLocalizedDescriptionKey: "Invaild access token"])
                     completionHandler(error,nil)
                    
               
                    return
            }
                
            }
            
        })
        
        task.resume()
        
        
        
        
    }
    


    
}
