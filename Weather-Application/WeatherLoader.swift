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
    var view: DailyWeatherView?
    var delegate: URLSessionResultDelegate? = nil
    
    func getDataModel() -> WeatherDataModel? { return weatherDataModel }
    
    let appID = "8b8358002d4bb6c08c08f037476cf8fd"
    let currentWeatherURL = "https://api.openweathermap.org/data/2.5/weather?q=Pinsk,by?&units=metric&APPID="
    let forecastWeatherURL = "https://api.openweathermap.org/data/2.5/forecast?q=Pinsk,by?&units=metric&APPID="
    
    func completeRequest() {
        let url = URL(string: currentWeatherURL + appID)!
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data, error == nil {
                do {
                    guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] else { return }
                    
                    guard let main = json["main"] as? [String: Any],
                        let wind = json["wind"] as? [String: Any],
                        let clouds = json["clouds"] as? [String: Any],
                        let name = json["name"] as? String,
                        let sys = json["sys"] as? [String: Any] else { return }
                    
                    guard let temperature = main["temp"] as? Double,
                        let pressure = main["pressure"] as? Int,
                        let humidity = main["humidity"] as? Int else { return }
                    
                    guard let speed = wind["speed"] as? Double,
                        let deg = wind["deg"] as? Int else { return }
                    
                    guard let allClouds = clouds["all"] as? Int else { return }
                    
                    guard let county = sys["country"] as? String else { return }
                                        
                    self.weatherDataModel = WeatherDataModel(city: name, country: county, temperature: Int(temperature), humidity: humidity, clouds: allClouds, pressure: pressure, windSpeed: Int(speed), windDirection: deg)
                    DispatchQueue.main.async {
                        self.delegate?.dataRetrieved()
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
////
////                    guard let main = json["main"] as? [String: Any],
////                        let wind = json["wind"] as? [String: Any],
////                        let clouds = json["clouds"] as? [String: Any],
////                        let name = json["name"] as? String,
////                        let sys = json["sys"] as? [String: Any] else { return }
////
////                    guard let temperature = main["temp"] as? Double,
////                        let pressure = main["pressure"] as? Int,
////                        let humidity = main["humidity"] as? Int else { return }
////
////                    guard let speed = wind["speed"] as? Double,
////                        let deg = wind["deg"] as? Int else { return }
////
////                    guard let allClouds = clouds["all"] as? Int else { return }
////
////                    guard let county = sys["country"] as? String else { return }
//
//                    self.weatherDataModel = WeatherDataModel(city: name, country: county, temperature: Int(temperature), humidity: humidity, clouds: allClouds, pressure: pressure, windSpeed: Int(speed), windDirection: deg)
                    DispatchQueue.main.async {
                        self.delegate?.dataRetrieved()
                    }
                
                } catch {
                    
                }
            }
        }
        task.resume()
    }
}
