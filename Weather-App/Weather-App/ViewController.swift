//
//  ViewController.swift
//  Weather-App
//
//  Created by Suman Chatterjee on 28/03/2017.
//  Copyright © 2017 Suman Chatterjee. All rights reserved.
//

import UIKit

class ViewController: UIViewController  , WeatherServiceDelegate {
    
    @IBOutlet weak var mainBannerView: UIView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var activityIndecator: UIActivityIndicatorView!
    
    var weatherService :WeatherService = WeatherService(appid: "53206ffa8c92b79f75b3ab4d7bd9f245")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isToolbarHidden = true
        self.mainBannerView.slideInFromTop()
        self.weatherService.delegate = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK:  Action ButtonDelegate methods
    @IBAction func performSearch(sender: AnyObject) {
        
        if self.textField.text == "" {
            
            let alertView = UIAlertController(title: "Oho! Some Error", message: "Please enter a City", preferredStyle: .alert)
            alertView.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alertView, animated: true, completion: nil)
            return
        }
        
        self.activityIndecator.startAnimating()
        self.performWeatherSearch()
    }
    
    
    func performWeatherSearch()  {
        
        guard let cityname = self.textField.text else {
            
            return
        }
        
        weatherService.getWeatherForCity(city: cityname)

    }
    
}

// MARK: WeatherService Delegate methods
/** Handles error message from Weather Service instance. */
extension ViewController {
    
    func setWeather() {
        
        self.activityIndecator.stopAnimating()
        let weaterTableViewController = self.storyboard?.instantiateViewController(withIdentifier: "WeaterTableViewController") as! WeaterTableViewController
        self.navigationController?.pushViewController(weaterTableViewController, animated: true)
    }
    
    func weatherErrorWithMessage(message: String){
        
        let alert = UIAlertController(title: "Weather Service Error", message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
        
    }
    

}

