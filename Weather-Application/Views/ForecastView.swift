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
    var forecastRecords: [[ForecastRecord]]?
    let cityTitle = UILabel()
    
    var headers = [String]()
    var rowsAtFirstSection = 0
    
    private let multicoloredLine = MulticoloredView()
    private var screenHeight: CGFloat = 0.0
    private var screenWidth: CGFloat = 0.0
    
    private let weekdays = [2: "Monday", 3: "Tuesday", 4: "Wednesday",
                    5: "Thursday", 6: "Friday", 7: "Saturday", 1: "Sunday"]
    
    private let reuseIdentifier = "forecastCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        forecastRecordsTableView = UITableView()
        forecastRecordsTableView!.rowHeight = 100
        forecastRecordsTableView!.translatesAutoresizingMaskIntoConstraints = false
        forecastRecordsTableView!.dataSource = self
        forecastRecordsTableView!.delegate = self
        forecastRecordsTableView!.register(ForecastRecordTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        defineHeaders()
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func defineHeaders() {
        let myDate = Date()
        var weekday = Calendar.current.component(.weekday, from: myDate)
        
        for _ in 0..<6 {
            headers.append(weekdays[weekday]!)
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
        
        self.addSubview(forecastRecordsTableView!)
        forecastRecordsTableView!.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(multicoloredLine.snp.bottom)
            make.bottom.equalToSuperview()
        }
    }
    
    private func setupTitle() {
        cityTitle.font = UIFont.systemFont(ofSize: 22)
        cityTitle.text = "City"
        
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
        } else if section == 5 {
            return (8 - rowsAtFirstSection)
        } else {
            return 8
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int  {
        if forecastRecords?.count != 0 {
            return 6
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if forecastRecords?.count != 0 {
            return headers[section]
        } else {
            return ""
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if forecastRecords?.count != 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! ForecastRecordTableViewCell
            
            let section = forecastRecords![indexPath.section]
            let rowData = section[indexPath.row]
            
            cell.tempLabel.text = rowData.temp
            cell.stateLabel.text = rowData.state
            cell.timeLabel.text = rowData.time
            
            let state = rowData.state
            var currentState: UIImage?
            switch (state) {
            case "Clear": currentState = UIImage(named: "Clear")
            case "Clouds": currentState = UIImage(named: "Clouds")
            case "Rain": currentState = UIImage(named: "Rain")
            case "Fog": currentState = UIImage(named: "Fog")
            case "Mist": currentState = UIImage(named: "Mist")
            default: break
            }
            
            if currentState != nil {
                cell.stateImage = currentState
                cell.updateStateImage()
            }
            
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
        
    
}
