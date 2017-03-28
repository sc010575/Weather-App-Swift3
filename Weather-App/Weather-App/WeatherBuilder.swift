//
//  WeatherBuilder.swift
//  Weather-App
//
//  Created by Suman Chatterjee on 28/03/2017.
//  Copyright © 2017 Suman Chatterjee. All rights reserved.
//

import Foundation


class WeatherBuilder {
    
    public typealias completionHandler = ( _ cancelled: Bool) -> Void

    
    var weatherList : [Weather] = []
    
    
    // MARK: - Initialization methods
    
    static let sharedInstance = WeatherBuilder()
    
}

extension  WeatherBuilder{
    
    func buildWeatherData(for weathers: Int , and records: JSON , completionhandler:@escaping completionHandler )  {
        
        weatherList.removeAll()
        
        guard let city  = records["city"]["name"].string else{
            
            return
        }
       
        for i in 0...weathers - 1 {
            
            
            let temp        = records["list"][i]["main"]["temp"].doubleValue
            let tempMin     = records["list"][i]["main"]["temp_min"].double
            let tempMax     = records["list"][i]["main"]["temp_max"].double
            let humidity    = records["list"][i]["main"]["humidity"].double
            let pressure    = records["list"][i]["main"]["pressure"].double
            let desc        = records["list"][i]["weather"][0]["description"].string ?? ""
            let icon        = records["list"][i]["weather"][0]["icon"].string ?? ""
            let clouds      = records["list"][i]["clouds"]["all"].double
            let windSpeed   = records["list"][i]["wind"]["speed"].double
            
            
            // Create a Weather struct to pass to the delegate.
            let weather = Weather(
                cityName: city,
                temp: temp,
                description: desc,
                icon: icon  ,
                clouds: clouds!,
                tempMin: tempMin!,
                tempMax: tempMax!,
                humidity: humidity!,
                pressure: pressure!,
                windSpeed: windSpeed!
            )
            
            self.weatherList.append(weather)
        }
        
        completionhandler(true)
    }
    
}


extension WeatherBuilder {
    
    struct Notification: NotificationNameRepresentable, RawRepresentable, ExpressibleByStringLiteral {
        
        let rawValue: String
        init?(rawValue: String) { self.rawValue = rawValue }
        init(stringLiteral value: String) { self.rawValue = value }
        init(extendedGraphemeClusterLiteral value: String) { self.rawValue = value }
        init(unicodeScalarLiteral value: String) { self.rawValue = value }
        
        static let didLoadNewWeatherData: Notification = "didLoadNewWeatherData"
    }
    
}


