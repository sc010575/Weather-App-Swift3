//
//  ViewController.swift
//  Weather-App
//
//  Created by Suman Chatterjee on 28/03/2017.
//  Copyright © 2017 Suman Chatterjee. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let weatherService :WeatherService = WeatherService(appid: "53206ffa8c92b79f75b3ab4d7bd9f245")
        weatherService.getWeatherForCity(city: "London")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

