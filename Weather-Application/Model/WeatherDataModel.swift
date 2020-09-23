//
//  WeatherDataModel.swift
//  Weather-Application
//
//  Created by sdf on 9/22/20.
//  Copyright © 2020 vmodzolevskii. All rights reserved.
//

import Foundation

enum WeatherState: String {
    case sunny
    // etc..
}

enum WindDirection: String {
    case SE
    // etc..
}

class WeatherForecast {
    var time = "" // maybe need to use Time type
    var weatherState: WeatherState = .sunny
    var temperature = 0
}

class WeatherDataModel {
    // main weather info
    var city: String
    var country: String
    var temperature: Int
    var weatherState: WeatherState = .sunny
    
    // details weather info
    var humidity: Int
    var clouds: Int
    var atmospherePressure: Int
    
    var windSpeed: Int
    var windDirection: Int
    
    init(city: String, country: String, temperature: Int, humidity: Int,
         clouds: Int, pressure: Int, windSpeed: Int, windDirection: Int) {
        self.city = city
        self.country = country
        self.temperature = temperature
        self.humidity = humidity
        self.clouds = clouds
        self.atmospherePressure = pressure
        self.windSpeed = windSpeed
        self.windDirection = windDirection
    }
}
