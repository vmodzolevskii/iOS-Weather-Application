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

class ForecastViewController: UIViewController, ForecastDataRetrevedDelegate {
    private weak var forecastView: ForecastView?
    private weak var weatherPresenter: WeatherPresenter?
    
    private var records: [ForecastRecord]?
    private var sortRecords = [[ForecastRecord]]()
    
    private var city: String?
    private var firstSectionRowCount = 0
    
    // MARK: Init
    init(presenter: WeatherPresenter) {
        self.weatherPresenter = presenter
        super.init(nibName: nil, bundle: nil)
        // verification on internet connection
        if ConnectivityVerification.isConnectedToInternet {
            guard let presenter = weatherPresenter else { return }
            presenter.forecastDataRetrievedDelegate = self
        } else {
            let alertManager = AlertManager()
            self.present(alertManager.absenceConnectionAlert(), animated: true)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = UIView(frame: UIScreen.main.bounds)
        self.view.backgroundColor = .white
        let forecastView = ForecastView(frame: UIScreen.main.bounds)
        forecastView.forecastRecords = sortRecords
        forecastView.rowsAtFirstSection = firstSectionRowCount
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
    
    // MARK: Public methods
    func updateForecast() {
        guard let presenter = weatherPresenter else { return }
        city = presenter.forecastCity
        records = presenter.forecast
        collectRecords()
    }
    
    // MARK: Private methods
    private func parseMonthDay(date: String) -> String {
        let startIndex = date.index(date.startIndex, offsetBy: 8)
        let endIndex = date.index(date.endIndex, offsetBy: -9)
        return String(date[startIndex..<endIndex])
    }
    
    private func collectRecords() {
        // define count rows in first section
        guard let weatherRecords = records else { return }
        let firstDay = parseMonthDay(date: weatherRecords[0].date)
        
        var rowsCount = 0

        for record in weatherRecords {
            let day = parseMonthDay(date: record.date)
            if firstDay == day {
                rowsCount += 1
            } else { break }
        }
        
        self.firstSectionRowCount = rowsCount
        let sectionSize: Int = 8
        let sectionRows = [rowsCount,
                           sectionSize,
                           sectionSize,
                           sectionSize,
                           sectionSize,
                           (sectionSize - rowsCount)]
        
        // split records on sections
        var summaryRows = 0
        for section in sectionRows {
            var dailyRecords = [ForecastRecord]()
            for _ in 0..<section {
                dailyRecords.append(weatherRecords[summaryRows])
                summaryRows += 1
            }
            sortRecords.append(dailyRecords)
        }
    }
}
