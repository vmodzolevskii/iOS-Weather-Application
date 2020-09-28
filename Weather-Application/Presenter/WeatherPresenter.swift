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
    var forecast: [ForecastRecord]?
    var forecastCity: String = ""
    
    private let weatherLoader = WeatherLoader()
    
    var weatherDataRetrievedDelegate: WeatherDataRetrievedDelegate? = nil
    var forecastDataRetrievedDelegate: ForecastDataRetrevedDelegate? = nil
    
    // MARK: Init
    init() {
        weatherLoader.weatherDelegate = self
        weatherLoader.forecastDelegate = self
    }
    
    // MARK: Public methods
    func completeRequests(with city: String, with country: String,
                          originalCity: String, originalCountry: String) {
        // update city and country
        weatherLoader.requestCity = city
        weatherLoader.requestCountry = country
        weatherLoader.originalCityName = originalCity
        weatherLoader.originalCountryName = originalCountry
        
        weatherLoader.completeWeatherRequest()
        weatherLoader.completeForecastRequest()
    }
    
    // MARK: Getters
    var city: String { return weatherLoader.originalCityName }
    
    var country: String { return weatherLoader.originalCountryName }
    
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
        forecastCity = weatherLoader.originalCityName
        forecastDataRetrievedDelegate?.updateForecast()
    }
}
