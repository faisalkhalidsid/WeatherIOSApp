//
//  WeatherForecastTableViewCell.swift
//  WeatherHBMSUDemo
//
//  Created by mac on 2018-08-01.
//  Copyright © 2018 faisalkhalid. All rights reserved.
//

import UIKit

class WeatherForecastTableViewCell: UITableViewCell {

    @IBOutlet weak var temp: UILabel!
    @IBOutlet weak var txt: UILabel!
    @IBOutlet weak var day: UILabel!
    @IBOutlet weak var img: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
