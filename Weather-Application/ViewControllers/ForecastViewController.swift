//
//  ForecastViewController.swift
//  Weather-Application
//
//  Created by sdf on 9/21/20.
//  Copyright © 2020 vmodzolevskii. All rights reserved.
//

import UIKit
import SnapKit

protocol ForecastDataRetrevedDelegate: class {
    func updateForecast()
}

struct ForecastRecord {
    var temp: String
    var state: String
    var time: String
    var date: String
}

class ForecastViewController: UIViewController, ForecastDataRetrevedDelegate {
    var forecastView: ForecastView?
    var weatherPresenter: WeatherPresenter
    var array: [[Any]]?
    var city: String?
    var records = [[ForecastRecord]]()
    var sectionRows: [Int]?
    
    init(presenter: WeatherPresenter) {
        self.weatherPresenter = presenter
        super.init(nibName: nil, bundle: nil)
        weatherPresenter.forecastDataRetrievedDelegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func updateForecast() {
        city = weatherPresenter.forecastCity!
        array = weatherPresenter.forecast
        collectRecords()
    }
    
    func collectRecords() {
        let dayOfMonth = array![0][2] as! String
        
        let startIndex = dayOfMonth.index(dayOfMonth.startIndex, offsetBy: 8)
        let endIndex = dayOfMonth.index(dayOfMonth.endIndex, offsetBy: -9)
        let superStr = String(dayOfMonth[startIndex..<endIndex])
        
        var firstHeaderCount = 0
        
        for index in 0..<array!.count {
            let dayOfMonth = array![index][2] as! String
            
            let startIndex = dayOfMonth.index(dayOfMonth.startIndex, offsetBy: 8)
            let endIndex = dayOfMonth.index(dayOfMonth.endIndex, offsetBy: -9)
            let substr = String(dayOfMonth[startIndex..<endIndex])
            
            if superStr == substr {
                firstHeaderCount += 1
            }
        }
        
        sectionRows = [firstHeaderCount, 8, 8, 8, 8, 8 - firstHeaderCount]
        var summaryRows = 0
        for section in sectionRows! {
            var dayRecords = [ForecastRecord]()
            
            for _ in 0..<section {
                let temp = String(Int(array![summaryRows][0] as! Double)) + "%@"
                let tempText  = NSString(format: temp as NSString, "\u{00B0}") as String
                
                let state = array![summaryRows][1] as! String
                
                let time = array![summaryRows][2] as! String
                let startIndex = time.index(time.startIndex, offsetBy: 11)
                let endIndex = time.index(time.endIndex, offsetBy: -3)
                let hours = String(time[startIndex..<endIndex])
                
                let record = ForecastRecord(temp: tempText, state: state, time: hours, date: time)
                dayRecords.append(record)
                summaryRows += 1
            }
            
            records.append(dayRecords)
        }
    }
    
    override func loadView() {
        self.view = UIView(frame: UIScreen.main.bounds)
        self.view.backgroundColor = .white
        let forecastView = ForecastView(frame: UIScreen.main.bounds)
        forecastView.forecastRecords = records
        forecastView.rowsAtFirstSection = sectionRows![0]
        forecastView.cityTitle.text = city
        self.forecastView = forecastView
        self.view.addSubview(forecastView)
        
        forecastView.snp.makeConstraints { make in
            make.left.equalTo(self.view.safeAreaLayoutGuide.snp.left)
            make.right.equalTo(self.view.safeAreaLayoutGuide.snp.right)
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        }
        
    }
}
