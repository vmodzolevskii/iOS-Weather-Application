//
//  JSONParsing.swift
//  Weather-Application
//
//  Created by sdf on 9/27/20.
//  Copyright © 2020 vmodzolevskii. All rights reserved.
//

import Foundation

class JSONParser {
    enum Tags: String {
        case weather
        case main
        case wind
        case clouds
        case name
        case sys
        case temp
        case pressure
        case humidity
        case speed
        case deg
        case all
        case country
        case city
        case list
        case dt_txt
    }
    
    private let json: [String: Any]
    
    init(with jsonData: [String: Any]) {
        self.json = jsonData
    }
    
    func parseCurrentWeather() -> WeatherDataModel? {
        guard let weather = json[Tags.weather.rawValue] as? [[String: Any]],
            let main = json[Tags.main.rawValue] as? [String: Any],
            let wind = json[Tags.wind.rawValue] as? [String: Any],
            let clouds = json[Tags.clouds.rawValue] as? [String: Any],
            let name = json[Tags.name.rawValue] as? String,
            let sys = json[Tags.sys.rawValue] as? [String: Any] else { return nil }
        
        guard let state = weather[0][Tags.main.rawValue] as? String,
                let temperature = main[Tags.temp.rawValue] as? Double,
                let pressure = main[Tags.pressure.rawValue] as? Int,
                let humidity = main[Tags.humidity.rawValue] as? Int,
                let speed = wind[Tags.speed.rawValue] as? Double,
                let deg = wind[Tags.deg.rawValue] as? Int,
                let allClouds = clouds[Tags.all.rawValue] as? Int,
                let county = sys[Tags.country.rawValue] as? String
        else { return nil }
        
        return WeatherDataModel(city: name, country: county, temperature: Int(temperature),
                                    state: state, humidity: humidity, clouds: allClouds,
                                    pressure: pressure, windSpeed: Int(speed), windDirection: deg)
    }
    
    func parseForecast() -> [ForecastRecord] {
        var records = [ForecastRecord]()
        
        guard let list = json[Tags.list.rawValue] as! [[String: Any]]? else {
            return [ForecastRecord]()
        }
        
        for record in list {
            guard let main = record[Tags.main.rawValue] as! [String: Any]?,
                let temp = main[Tags.temp.rawValue] as! Double?,
                let weather = record[Tags.weather.rawValue] as! [[String: Any]]?,
                let state = weather[0][Tags.main.rawValue] as! String?,
                let date = record[Tags.dt_txt.rawValue] as! String? else {
                    return [ForecastRecord]()
            }
            
            let time = parseTextTime(date: date)
            let tempCelsius = addCelsiucPostfix(temp: String(Int(temp)))

            records.append(ForecastRecord(temp: tempCelsius, state: state, time: time, date: date))
        }
        
        return records
    }
    
    private func addCelsiucPostfix(temp: String) -> String {
        let tempCelsius = temp + "%@"
        return NSString(format: tempCelsius as NSString, "\u{00B0}") as String
    }
    
    private func parseTextTime(date: String) -> String {
        let startIndex = date.index(date.startIndex, offsetBy: 11)
        let endIndex = date.index(date.endIndex, offsetBy: -3)
        return String(date[startIndex..<endIndex])
    }
}
