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
    var city = ""
    var country = ""
    var temperature = 0
    var weatherState: WeatherState = .sunny
    
    // details weather info
    var rainChance = 0
    var rainfall = 0
    var atmospherePressure = 0
    var windSpeed = 0
    var windDirection: WindDirection = .SE
    
    // weather forecast for 5 day with 3 hours intervals
    var forecase = [WeatherForecast]()
}
