//
//  WeatherLoader.swift
//  Weather-Application
//
//  Created by sdf on 9/23/20.
//  Copyright © 2020 vmodzolevskii. All rights reserved.
//

import Foundation


class WeatherLoader {
    var weatherDataModel: WeatherDataModel?
    var forecastData = [[Any]]()
    var city = ""
    
    var weatherDelegate: WeatherResultDelegate? = nil
    var forecastDelegate: ForecastResultDelegate? = nil
    
    func getDataModel() -> WeatherDataModel? { return weatherDataModel }
    func getForecastData() -> [[Any]] { return forecastData }
    func getCityName() -> String { return city }
    
    let appID = "8b8358002d4bb6c08c08f037476cf8fd"
    let currentWeatherURL = "https://api.openweathermap.org/data/2.5/weather?q=Moscow,ru?&units=metric&APPID="
    let forecastWeatherURL = "https://api.openweathermap.org/data/2.5/forecast?q=London,uk?&units=metric&APPID="
    
    func completeRequest() {
        let url = URL(string: currentWeatherURL + appID)!
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data, error == nil {
                do {
                    guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] else { return }
                    
                    guard let weather = json["weather"] as? [[String: Any]],
                        let main = json["main"] as? [String: Any],
                        let wind = json["wind"] as? [String: Any],
                        let clouds = json["clouds"] as? [String: Any],
                        let name = json["name"] as? String,
                        let sys = json["sys"] as? [String: Any] else { return }
                    
                    guard let state = weather[0]["main"] as? String else { return }
                    
                    guard let temperature = main["temp"] as? Double,
                        let pressure = main["pressure"] as? Int,
                        let humidity = main["humidity"] as? Int else { return }
                    
                    guard let speed = wind["speed"] as? Double,
                        let deg = wind["deg"] as? Int else { return }
                    
                    guard let allClouds = clouds["all"] as? Int else { return }
                    
                    guard let county = sys["country"] as? String else { return }
                                        
                    self.weatherDataModel = WeatherDataModel(city: name, country: county, temperature: Int(temperature),
                                                             state: state, humidity: humidity, clouds: allClouds,
                                                             pressure: pressure, windSpeed: Int(speed), windDirection: deg)
                    DispatchQueue.main.async {
                        self.weatherDelegate?.weatherDataRetrieved()
                    }
                
                } catch {
                    
                }
            }
        }
        task.resume()
    }
    
    func completeForecastRequest() {
        let url = URL(string: forecastWeatherURL + appID)!
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data, error == nil {
                do {
                    guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] else { return }
                    
                    guard let city = json["city"] as! [String: Any]? else { return }
                    guard let cityname = city["name"] as! String? else { return }
                    
                    self.city = cityname
                    
                    for index in 0..<40 {
                        guard let list = json["list"] as! [[String: Any]]? else { return }
                        
                        guard let main = list[index]["main"] as! [String: Any]? else { return }
                        guard let temp = main["temp"] as! Double? else { return }
                        
                        guard let weather = list[index]["weather"] as! [[String: Any]]? else { return }
                        guard let mainState = weather[0]["main"] as! String? else { return }
                        
                        guard let date = list[index]["dt_txt"] as! String? else { return }
                        
                        let array = [temp as Any, mainState as Any, date as Any]
                        self.forecastData.append(array)
                    }
                    
                    DispatchQueue.main.async {
                        self.forecastDelegate?.forecastDataRetrieved()
                    }
                
                } catch {
                    
                }
            }
        }
        task.resume()
    }
}
