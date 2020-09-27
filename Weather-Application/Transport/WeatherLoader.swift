//
//  WeatherLoader.swift
//  Weather-Application
//
//  Created by sdf on 9/23/20.
//  Copyright © 2020 vmodzolevskii. All rights reserved.
//

import Foundation


class WeatherLoader {
    private var weatherDataModel: WeatherDataModel?
    private var forecastData = [ForecastRecord]()
    
    var originalCityName = ""
    var originalCountryName = ""
    var requestCity = ""
    var requestCountry = ""

    var weatherDelegate: WeatherResultDelegate? = nil
    var forecastDelegate: ForecastResultDelegate? = nil
    
    func getDataModel() -> WeatherDataModel? { return weatherDataModel }
    func getForecastData() -> [ForecastRecord] { return forecastData }
    func getCityName() -> String { return originalCityName }
    
    private let appID = "8b8358002d4bb6c08c08f037476cf8fd"
    private let postfix = "?&units=metric&APPID="
    private let currentWeatherURL = "https://api.openweathermap.org/data/2.5/weather?q="
    private let forecastWeatherURL = "https://api.openweathermap.org/data/2.5/forecast?q="
    
    func completeRequest() {
        guard let url = URL(string: currentWeatherURL + requestCity +
                                            "," + requestCountry + postfix + appID) else {
            print("invalid url")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data, error == nil {
                do {
                    guard let json = try JSONSerialization
                                    .jsonObject(with: data,
                                        options: .mutableContainers) as?
                                            [String: Any] else { return }
                    
                    let parser = JSONParser(with: json)
                    guard let weather = parser.parseCurrentWeather() else { return }
                    self.weatherDataModel = weather
                    
                    DispatchQueue.main.async {
                        self.weatherDelegate?.weatherDataRetrieved()
                    }
                
                } catch {
                    debugPrint("json parsing error")
                }
            }
        }
        task.resume()
    }
    
    func completeForecastRequest() {
        dispatchPrecondition(condition: .onQueue(.main))
        guard let url = URL(string: forecastWeatherURL + requestCity
                                + "," + requestCountry + postfix + appID) else {
            print("invalid url")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data, error == nil {
                do {
                    guard let json = try JSONSerialization
                        .jsonObject(with: data,
                            options: .mutableContainers) as?
                                [String: Any] else { return }
                     
                    let parser = JSONParser(with: json)
                    let forecast = parser.parseForecast()
                    self.forecastData = forecast
                    
                    DispatchQueue.main.async {
                        self.forecastDelegate?.forecastDataRetrieved()
                    }
                
                } catch {
                    debugPrint("json parsing error")
                }
            }
        }
        task.resume()
    }
}
