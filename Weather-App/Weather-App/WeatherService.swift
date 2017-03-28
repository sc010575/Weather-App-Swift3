//
//  WeatherService.swift
//  Weather-App
//
//  Created by Suman Chatterjee on 28/03/2017.
//  Copyright © 2017 Suman Chatterjee. All rights reserved.
//

import Foundation

import UIKit

protocol WeatherServiceDelegate {
    func setWeather(weather: Weather)
    func weatherErrorWithMessage(message: String)
}


class WeatherService {
    // Set your appid
    let appid: String
    var delegate: WeatherServiceDelegate?
    
    /** Initial a WeatherService instance with your OpenWeatherMap app id. */
    init(appid: String) {
        self.appid = appid
    }
    
    /** Formats an API call to the OpenWeatherMap service. Pass in a string in the form City Name, Country. */
    func getWeatherForCity(city: String) {
     //   if let cityEscaped = city.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLHostAllowedCharacterSet()) {
        
            let path = "http://api.openweathermap.org/data/2.5/forecast?q=Staines,GB&mode=JSON&appid=\(appid)"
            
            getWeatherWithPath(path: path)
    }
    
    /** This Method retrieves weather data from an API path. */
    func getWeatherWithPath(path: String) {
        // Create a URL, Session, and Data task.
        guard let  url = URL(string: path) else{
            
            print("Error: cannot create URL")
            return

        }
        

        let config = URLSessionConfiguration.default // Session Configuration
        let session = URLSession(configuration: config) // Load configuration into Session

        
        let task = session.dataTask(with: url) {
            (data, response, error) in
            
            // Handle an HTTP status response.
            if let httpResponse = response as? HTTPURLResponse {
                print("*******")
                print(httpResponse.statusCode)
                print("*******")
            }
            
            // Check for nil data
            let json = JSON(data: data!)
            // print(json)
            if json == nil {
                return
            }
            
            // Get the cod code: 401 Unauthorized, 404 file not found, 200 Ok!
            // ! OpenWeatherMap returns 404 as a string but 401 and 200 are Int!?
            var status = 0
            
            if let cod = json["cod"].int {
                status = cod
            } else if let cod = json["cod"].string {
                status = Int(cod)!
            }
            
            // Check status
            // print("Weather status code:\(status)")
            if status == 200 {
                // everything is ok get the weather data from the json data.
                let weather = self.prepareFor(json: json)
                DispatchQueue.main.async {
                    
                        self.delegate?.setWeather(weather: weather)
                }
            

            
            } else if status == 404 {
                // City not found
                if self.delegate != nil {
                    DispatchQueue.main.async {
                        self.delegate?.weatherErrorWithMessage(message: "City not found")
                    }
                }
                
            } else {
                // Some other here?
                if self.delegate != nil {
                    DispatchQueue.main.async {

                        self.delegate?.weatherErrorWithMessage(message: "Something went wrong?")
                    }
                }
                
            }
            
        }
    
    
        // *** This starts the data session ***
        task.resume()
    }

    func prepareFor (json : JSON) -> Weather {
        
        print(json)
        let _ = json["coord"]["lon"].double
        let _ = json["coord"]["lat"].double
        
        let list = json["list"].arrayObject as! [[String:Any]]
        
        let temp =  json["list"][0]["main"]["temp"].doubleValue
        let tempMin = json["list"][0]["main"]["temp_min"].double
        let tempMax = json["list"][0]["main"]["temp_max"].double
        let humidity = json["list"][0]["main"]["humidity"].double
        let pressure = json["list"][0]["main"]["pressure"].double
        let name = json["list"][0]["name"].string
        let desc = json["list"][0]["weather"][0]["description"].string
        let icon = json["list"][0]["weather"][0]["icon"].string
        let clouds = json["list"][0]["clouds"]["all"].double
        let windSpeed = json["list"][0]["wind"]["speed"].double

        
        // Create a Weather struct to pass to the delegate.
        let weather = Weather(
            cityName: name!,
            temp: temp,
            description: desc!,
            icon: icon!,
            clouds: clouds!,
            tempMin: tempMin!,
            tempMax: tempMax!,
            humidity: humidity!,
            pressure: pressure!,
            windSpeed: windSpeed!
        )
        
        return weather
    }

}
