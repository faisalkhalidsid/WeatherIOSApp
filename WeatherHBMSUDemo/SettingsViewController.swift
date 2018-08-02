//
//  SettingsViewController.swift
//  WeatherHBMSUDemo
//
//  Created by faisal khalid on 8/1/18.
//  Copyright © 2018 faisalkhalid. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var celciusSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = UserDefaults.standard

        if let isCelcius = defaults.object(forKey: "Celcius") as? Bool {
                DispatchQueue.main.async {
                    self.celciusSwitch.isOn = isCelcius
                }
          
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func goBack(_ sender: Any) {
        DispatchQueue.main.async {
            self.navigationController?.popViewController(animated: false)
        }
    }
    
    @IBAction func measurementChanged(_ sender: UISwitch) {
        
        let defaults = UserDefaults.standard
        
    
        defaults.set(sender.isOn, forKey: "Celcius")
        
        if sender.isOn {
        Settings.weatherUnit = WeatherUnit.CELCIUS
        }
        else {
            Settings.weatherUnit = WeatherUnit.FAHRENHEIT
        }
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
