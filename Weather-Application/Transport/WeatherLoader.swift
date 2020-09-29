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
    var alertTitle: String?
    var alertMessage: String?

    var weatherDelegate: WeatherResultDelegate? = nil
    var forecastDelegate: ForecastResultDelegate? = nil
    
    func getDataModel() -> WeatherDataModel? { return weatherDataModel }
    func getForecastData() -> [ForecastRecord] { return forecastData }
    func getCityName() -> String { return originalCityName }
    
    private let appID = "8b8358002d4bb6c08c08f037476cf8fd"
    private let postfix = "?&units=metric&APPID="
    private let currentWeatherURL = "https://api.openweathermap.org/data/2.5/weather?q="
    private let forecastWeatherURL = "https://api.openweathermap.org/data/2.5/forecast?q="
    
    
    // MARK: URL building
    private func buildWeatherUrl() -> URL? {
        guard let url = URL(string: currentWeatherURL  + requestCity +
                                        "," + requestCountry + postfix + appID) else {
            let alertTitle = AlertMessages.invalidURLTitle.rawValue
            let alertMessage = AlertMessages.invalidURLMessage.rawValue
            self.weatherDelegate?.weatherDataError(title: alertTitle, message: alertMessage)
            return nil
        }
        return url
    }
    
    private func buildForecastUrl() -> URL? {
        guard let url = URL(string: forecastWeatherURL  + requestCity +
            "," + requestCountry + postfix + appID) else {
            let alertTitle = AlertMessages.invalidURLTitle.rawValue
            let alertMessage = AlertMessages.invalidURLMessage.rawValue
            self.forecastDelegate?.forecastDataError(title: alertTitle, message: alertMessage)
            return nil
        }
        return url
    }
  
    
    // MARK: Public methods
    func completeWeatherRequest() {
        dispatchPrecondition(condition: .onQueue(.main))
        guard let url = buildWeatherUrl() else { return }
        
        URLSession.shared.dataTask(with: url) { (result) in
            switch result {
            case .success(let data, let urlResponse):
                if urlResponse.statusCode == 200 {
                    self.parseWeatherData(with: data)
                } else {
                    DispatchQueue.main.async {
                        self.weatherDelegate?.weatherDataError(
                            title: AlertMessages.wrongServerStatusTitle.rawValue,
                            message: AlertMessages.wrongServerStatusMessage.rawValue)
                    }
                }
            case .failure:
                DispatchQueue.main.async {
                    self.weatherDelegate?.weatherDataError(
                        title: AlertMessages.serverRequestErrorTitle.rawValue,
                        message: AlertMessages.serverRequestErrorMessage.rawValue)
                }
            }
        }.resume()
    }
    
    func completeForecastRequest() {
        dispatchPrecondition(condition: .onQueue(.main))
        guard let url = buildForecastUrl() else { return }
        
        URLSession.shared.dataTask(with: url) { (result) in
            switch result {
            case .success(let data, let urlResponse):
                if urlResponse.statusCode == 200 {
                    self.parseForecastData(with: data)
                } else {
                    DispatchQueue.main.async {
                        self.forecastDelegate?.forecastDataError(
                            title: AlertMessages.wrongServerStatusTitle.rawValue,
                            message: AlertMessages.wrongServerStatusMessage.rawValue)
                    }
                }
            case .failure:
                DispatchQueue.main.async {
                    self.forecastDelegate?.forecastDataError(
                        title: AlertMessages.serverRequestErrorTitle.rawValue,
                        message: AlertMessages.serverRequestErrorMessage.rawValue)
                }
            }
        }.resume()
    }
    
    // MARK: Private methods
    private func parseWeatherData(with data: Data) {
        do {
            guard let json = try JSONSerialization.jsonObject(with: data,
                                options: .mutableContainers) as? [String: Any] else { return }
            let parser = JSONParser(with: json)
            guard let weather = parser.parseCurrentWeather() else { return }
            self.weatherDataModel = weather
            
            DispatchQueue.main.async {
                self.weatherDelegate?.weatherDataRetrieved()
            }
        } catch {
            DispatchQueue.main.async {
                self.weatherDelegate?.weatherDataError(
                    title: AlertMessages.incorrectJSONFormatTitle.rawValue,
                    message: AlertMessages.incorrectJSONFormatMessage.rawValue)
            }
        }
    }
    
    private func parseForecastData(with data: Data) {
        do {
            guard let json = try JSONSerialization.jsonObject(with: data,
                                options: .mutableContainers) as? [String: Any] else { return }
            let parser = JSONParser(with: json)
            let forecast = parser.parseForecast()
            self.forecastData = forecast
            
            DispatchQueue.main.async {
                self.forecastDelegate?.forecastDataRetrieved()
            }
        } catch {
            DispatchQueue.main.async {
                self.forecastDelegate?.forecastDataError(
                    title: AlertMessages.incorrectJSONFormatTitle.rawValue,
                    message: AlertMessages.incorrectJSONFormatMessage.rawValue)
            }
        }
    }
}

