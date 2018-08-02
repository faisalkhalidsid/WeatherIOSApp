//
//  WeatherDetailViewController.swift
//  WeatherHBMSUDemo
//
//  Created by faisal khalid on 8/1/18.
//  Copyright © 2018 faisalkhalid. All rights reserved.
//

import UIKit

class WeatherDetailViewController: UIViewController {

    
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var image: UIImage?
    @IBOutlet weak var descriptionTxt: UILabel!
    @IBOutlet weak var temperature: UILabel!
    public var weather:WeatherForecast?
    public var selectedLocation:WeatherLocation?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        DispatchQueue.main.async {
            
            self.location.text = "\(self.selectedLocation!.city), \(self.selectedLocation!.country)"

            self.img.image = self.image
            if Settings.weatherUnit == WeatherUnit.FAHRENHEIT {
                self.descriptionTxt.text = "\(self.weather!.text) with a high of \(self.weather!.high) and a low of \(self.weather!.low)."
                self.temperature.text = self.weather!.temp
                
            }
            else {
                self.descriptionTxt.text = "\(self.weather!.text) with a high of \(WeatherForecast.inCelcius(temp: self.weather!.high)) and a low of \(WeatherForecast.inCelcius(temp: self.weather!.low))."
                self.temperature.text = WeatherForecast.inCelcius(temp: self.weather!.temp)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
