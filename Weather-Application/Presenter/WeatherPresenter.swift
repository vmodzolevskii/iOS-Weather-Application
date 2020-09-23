//
//  WeatherPresenter.swift
//  Weather-Application
//
//  Created by sdf on 9/22/20.
//  Copyright © 2020 vmodzolevskii. All rights reserved.
//

import Foundation

public protocol URLSessionResultDelegate: class {
    func dataRetrieved()
}

class WeatherPresenter: URLSessionResultDelegate {
    private var weatherDataModel: WeatherDataModel?
    let weatherLoader = WeatherLoader()
    
    var dataRetrievedDelegate: DataRetrievedDelegate? = nil
    
    init() {
        weatherLoader.delegate = self
        weatherLoader.completeRequest()
    }
    
    // MARK: Getters
    var city: String {
        return (weatherDataModel != nil) ? weatherDataModel!.city : ""
    }
    
    var country: String { return (weatherDataModel != nil) ?
        weatherDataModel!.country : ""
    }
    
    var temperature: String { return (weatherDataModel != nil) ?
        String(weatherDataModel!.temperature) : ""
    }
    
    var humidity: String {
        return (weatherDataModel != nil) ? String(weatherDataModel!.humidity) : ""
    }
    
    var clouds: String {
        return (weatherDataModel != nil) ? String(weatherDataModel!.clouds) : ""
    }
    
    var pressure: String {
        return (weatherDataModel != nil) ? String(weatherDataModel!.atmospherePressure) : ""
    }
    
    var speed: String {
        return (weatherDataModel != nil) ? String(weatherDataModel!.windSpeed) : ""
    }
    
    var direction: String {
        return (weatherDataModel != nil) ? String(weatherDataModel!.windDirection) : ""
    }
    
    
    // MARK: URLSessionResultDelegate
    func dataRetrieved() {
        print("data retrieved")
        weatherDataModel = weatherLoader.getDataModel()
        dataRetrievedDelegate?.updateUI()
    }
}
