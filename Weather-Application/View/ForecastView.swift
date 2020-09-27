//
//  ForecastView.swift
//  Weather-Application
//
//  Created by sdf on 9/22/20.
//  Copyright © 2020 vmodzolevskii. All rights reserved.
//

import UIKit
import SnapKit

class ForecastView: UIView, UITableViewDataSource, UITableViewDelegate {
    private var forecastRecordsTableView: UITableView?
    
    let cityTitle = UILabel()
    var forecastRecords: [[ForecastRecord]]?
    var rowsAtFirstSection = 0

    private var headers = [String]()
    
    private let multicoloredLine = MulticoloredView()
    private var screenHeight: CGFloat = 0.0
    private var screenWidth: CGFloat = 0.0
    
    private let sectionsCount = 6
    private let defaultRowsCount = 8
    
    private let weekdays = [2: "Monday", 3: "Tuesday", 4: "Wednesday",
                    5: "Thursday", 6: "Friday", 7: "Saturday", 1: "Sunday"]
    
    private let reuseIdentifier = "forecastCell"
    
    
    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupTableView()
        defineHeaders()
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Setup views
    private func setupTableView() {
        forecastRecordsTableView = UITableView()
        guard let recordsTableView = forecastRecordsTableView else { return }
        recordsTableView.rowHeight = 100
        recordsTableView.translatesAutoresizingMaskIntoConstraints = false
        recordsTableView.dataSource = self
        recordsTableView.delegate = self
        recordsTableView.register(ForecastRecordTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
    }
    
    private func defineHeaders() {
        let myDate = Date()
        var weekday = Calendar.current.component(.weekday, from: myDate)
        
        for _ in 0..<sectionsCount {
            guard let dayName = weekdays[weekday] else { return }
            headers.append(dayName)
            weekday += 1
            if weekday == 8 {
                weekday = 1
            }
        }
    }
    
    private func setupViews() {
        let size = UIScreen.main.bounds
        screenHeight = size.height
        screenWidth = size.width
        
        setupTitle()
        
        guard let tableView = forecastRecordsTableView else { return }
        self.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(multicoloredLine.snp.bottom)
            make.bottom.equalToSuperview()
        }
    }
    
    private func setupTitle() {
        cityTitle.font = UIFont.systemFont(ofSize: 22)
        cityTitle.text = "-"
        
        let titleView = UIView()
        titleView.addSubview(cityTitle)
        self.addSubview(titleView)
        
        titleView.snp.makeConstraints { make in
            make.height.equalTo(screenHeight / 15)
            make.left.top.right.equalToSuperview()
        }
        
        cityTitle.snp.makeConstraints { make in
            make.center.equalTo(titleView)
        }
        
        multicoloredLine.setNeedsDisplay()
        self.addSubview(multicoloredLine)
        multicoloredLine.snp.makeConstraints { make in
            make.height.equalTo(2)
            make.width.equalTo(screenWidth)
            make.top.equalTo(titleView.snp.bottom)
        }
    }
    
    
    // MARK: UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return rowsAtFirstSection
        } else if section == (sectionsCount - 1) {
            return (defaultRowsCount - rowsAtFirstSection)
        } else {
            return defaultRowsCount
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int  {
        guard let records = forecastRecords else { return 0 }
        return records.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard forecastRecords != nil else { return "" }
        return headers[section]
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if forecastRecords?.count != 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! ForecastRecordTableViewCell
            
            guard let records = forecastRecords else { return UITableViewCell() }
            let section = records[indexPath.section]
            let rowData = section[indexPath.row]
            
            cell.tempLabel.text = rowData.temp
            cell.stateLabel.text = rowData.state
            cell.timeLabel.text = rowData.time
            
            let currentState = updateStateImage(state: rowData.state)
            cell.stateImage = currentState
            cell.updateStateImage()
            
            return cell
        }
        return UITableViewCell()
    }
    
    // MARK: Private methods
    private func updateStateImage(state: String) -> UIImage? {
        var currentState: UIImage?
        switch (state) {
        case "Clear": currentState = UIImage(named: "Clear")
        case "Clouds": currentState = UIImage(named: "Clouds")
        case "Rain": currentState = UIImage(named: "Rain")
        case "Fog": currentState = UIImage(named: "Fog")
        case "Mist": currentState = UIImage(named: "Mist")
        case "Haze": currentState = UIImage(named: "Haze")
        default: currentState = UIImage(named: "Placeholder")
        }
        
        return currentState
    }
}
