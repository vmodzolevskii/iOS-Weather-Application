//
//  WeatherDataModel.swift
//  Weather-Application
//
//  Created by sdf on 9/22/20.
//  Copyright © 2020 vmodzolevskii. All rights reserved.
//

import Foundation

class WeatherDataModel {
    // main weather info
    var city: String
    var country: String
    var temperature: Int
    var state: String
    
    // details weather info
    var humidity: Int
    var clouds: Int
    var atmospherePressure: Int
    var windSpeed: Int
    var windDirection: Int
    
    init(city: String, country: String, temperature: Int,
         state: String, humidity: Int, clouds: Int,
         pressure: Int, windSpeed: Int, windDirection: Int) {
        
        self.city = city
        self.country = country
        self.temperature = temperature
        self.state = state
        self.humidity = humidity
        self.clouds = clouds
        self.atmospherePressure = pressure
        self.windSpeed = windSpeed
        self.windDirection = windDirection
    }
}

enum DataModel: String {
    case city
    case country
    case temp
    case state
    
    case details
}
