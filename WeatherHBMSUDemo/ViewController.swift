//
//  ViewController.swift
//  WeatherHBMSUDemo
//
//  Created by mac on 2018-08-01.
//  Copyright © 2018 faisalkhalid. All rights reserved.
//

import UIKit
import CoreLocation
import UserNotifications

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var mesurementUnit: UILabel!
    var forecasts:[WeatherForecast] = []
    var weather:Weather?
    var timer: Timer!

    var location:CLLocationCoordinate2D?
    
    @IBOutlet weak var currentIMG: UIImageView!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.forecasts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "forecastcell") as! WeatherForecastTableViewCell
        cell.day.text = forecasts[indexPath.row].day
        
        if Settings.weatherUnit == WeatherUnit.CELCIUS {
            cell.temp.text =  "\(WeatherForecast.inCelcius(temp: forecasts[indexPath.row].temp)).C"
        }
        else {
            cell.temp.text =  "\(forecasts[indexPath.row].temp).F"

        }
        
        
        
        cell.txt.text =  forecasts[indexPath.row].text
        
        let url = URL(string: "http://l.yimg.com/a/i/us/we/52/\(forecasts[indexPath.row].code).gif")
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url!)
            DispatchQueue.main.async {
                cell.img.image = UIImage(data: data!)
            }
        }
        return cell
        
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        DispatchQueue.main.async {
            var controller = self.storyboard?.instantiateViewController(withIdentifier: "detailview") as! WeatherDetailViewController
            controller.weather = self.forecasts[indexPath.row]
            controller.selectedLocation = self.weather?.location
            
            var cell = tableView.cellForRow(at: indexPath) as! WeatherForecastTableViewCell
            controller.image = cell.img.image
            self.navigationController?.pushViewController(controller, animated: false)
        }
    }

    @IBOutlet weak var currentTemp: UILabel!
    @IBOutlet weak var selectedCity: UILabel!
    @IBOutlet weak var forecastTableView: UITableView!
    var defaults:UserDefaults?
    override func viewDidLoad() {
        super.viewDidLoad()
        
      

        
        
        var build = BuildType.development
        if build == .development {
        self.title = "Weather App Development"
        }
        else if build == .production {
             self.title = "Weather App Production"
        }
        
        
         defaults = UserDefaults.standard

        
        if let isCelcius = defaults!.object(forKey: "Celcius") as? Bool {
            if isCelcius {
                Settings.weatherUnit = WeatherUnit.CELCIUS
            }
            else {
                Settings.weatherUnit = WeatherUnit.FAHRENHEIT

            }
        }
        else {
            Settings.weatherUnit = WeatherUnit.FAHRENHEIT

        }
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
        forecastTableView.delegate = self
        var weatherClient = WeatherClient()
          location = CLLocationCoordinate2D.init(latitude: 25.322327, longitude: 55.513641)
       // abu dhabi 24.4539° N, 54.3773° E

        
        var timer  = Timer.scheduledTimer(timeInterval: 60000*15 ,
                                          target: self,
                                          selector: #selector(self.updateWeather(_:)),
                                          userInfo: nil,
                                          repeats: true)

        updateWeather(timer)
       
       
    }

    @IBAction func gotoSettings(_ sender: Any) {
        
        
    }

    override func viewWillAppear(_ animated: Bool) {
        
       
        
        if let weather = weather {
            
            DispatchQueue.main.async {
                if Settings.weatherUnit == WeatherUnit.CELCIUS {
                self.currentTemp.text = WeatherForecast.inCelcius(temp: weather.current.temperature)
                    
                self.mesurementUnit.text = "o C"
                }
                else {
                    self.currentTemp.text = weather.current.temperature

                    self.mesurementUnit.text = "o F"
                }
                 self.forecastTableView.reloadData()
            }
        }
        
    }
    
    
    
    func scheduleLocal() {
        print("notification")
        let center = UNUserNotificationCenter.current()
        
        let content = UNMutableNotificationContent()
        let defaults = UserDefaults.standard

        
        content.title = (self.weather?.location.country)!
        content.body = defaults.object(forKey: "Notification") as! String
        content.categoryIdentifier = "alarm"
        content.sound = UNNotificationSound.default()
        
        var dateComponents = DateComponents()
        dateComponents.hour = 14
        dateComponents.minute = 00
      let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
    //    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)

        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        center.add(request)
        
    }
    
    
    @objc func updateWeather(_ timer: AnyObject) {
        var weatherClient = WeatherClient()
         weatherClient.getWeatherByLatLong(cordinate: location!) { error, data in
            if let data = data {
                
                self.weather = data
                
                
                self.defaults!.setValue("Tomorrow we are expecting mostly sunny with a high of \(data.forecast![0].high) °F (\(WeatherForecast.inCelcius(temp: data.forecast![1].high)) °C) and a low of \(data.forecast![1].low) °F (\(WeatherForecast.inCelcius(temp: data.forecast![1].low)) °C).", forKey: "Notification")
                
                
                DispatchQueue.main.async {
                    
                    if Settings.weatherUnit == WeatherUnit.CELCIUS {
                        self.currentTemp.text = WeatherForecast.inCelcius(temp: data.current.temperature)
                        self.mesurementUnit.text = "o C"
                    }
                    else {
                        self.currentTemp.text = data.current.temperature
                        self.mesurementUnit.text = "o F"
                    }
                    
                    
                    self.selectedCity.text = "\(data.location.city), \(data.location.country)"
                    self.forecasts = data.forecast!
                    self.forecastTableView.reloadData()
                    
                    
                    let url = URL(string: "http://l.yimg.com/a/i/us/we/52/\(data.current.code).gif")
                    DispatchQueue.global().async {
                        let data = try? Data(contentsOf: url!)
                        DispatchQueue.main.async {
                            self.currentIMG.image = UIImage(data: data!)
                        }
                    }
                    
                    
                }
                let center = UNUserNotificationCenter.current()
                
                center.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
                    if granted {
                        self.scheduleLocal()
                    }
                }
        }
        
    }

    }}
enum BuildType {
    case development, production
}
