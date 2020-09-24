//
//  WeatherPresenter.swift
//  Weather-Application
//
//  Created by sdf on 9/22/20.
//  Copyright © 2020 vmodzolevskii. All rights reserved.
//

import Foundation

public protocol WeatherResultDelegate: class {
    func weatherDataRetrieved()
}

public protocol ForecastResultDelegate: class {
    func forecastDataRetrieved()
}

class WeatherPresenter: WeatherResultDelegate, ForecastResultDelegate {
    private var weatherDataModel: WeatherDataModel?
    var forecast: [[Any]]?
    var forecastCity: String?
    
    let weatherLoader = WeatherLoader()
    
    var weatherDataRetrievedDelegate: WeatherDataRetrievedDelegate? = nil
    var forecastDataRetrievedDelegate: ForecastDataRetrevedDelegate? = nil
    
    init() {
        weatherLoader.weatherDelegate = self
        weatherLoader.forecastDelegate = self
        weatherLoader.completeRequest()
        weatherLoader.completeForecastRequest()
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
    
    var state: String { return (weatherDataModel != nil) ?
        String(weatherDataModel!.state) : ""
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
    
    
    
    
    // MARK: WeatherResultDelegate
    func weatherDataRetrieved() {
        weatherDataModel = weatherLoader.getDataModel()
        weatherDataRetrievedDelegate?.updateWeather()
    }
    
    // MARK: ForecastResultDelegate
    func forecastDataRetrieved() {
        forecast = weatherLoader.getForecastData()
        forecastCity = weatherLoader.getCityName()
        forecastDataRetrievedDelegate?.updateForecast()
    }
}
