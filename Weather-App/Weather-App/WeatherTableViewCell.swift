//
//  WeatherTableViewCell.swift
//  Weather-App
//
//  Created by Suman Chatterjee on 29/03/2017.
//  Copyright © 2017 Suman Chatterjee. All rights reserved.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {
    
    @IBOutlet weak var descriptionLabel: UILabel!

    @IBOutlet weak var weatherConditionImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
