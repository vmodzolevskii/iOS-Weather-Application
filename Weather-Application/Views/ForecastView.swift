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
    var forecastRecordsTableView: UITableView?
    
    var forecastRecords: [[ForecastRecord]]?
    
    let multicoloredLine = MulticoloredView()
    let cityTitle = UILabel()
    var screenHeight: CGFloat = 0.0
    var screenWidth: CGFloat = 0.0
    
    let weekdays = [2: "Monday", 3: "Tuesday", 4: "Wednesday",
                    5: "Thursday", 6: "Friday", 7: "Saturday", 1: "Sunday"]
    var headers = [String]()
    
    var rowsAtFirstSection = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        forecastRecordsTableView = UITableView()
        forecastRecordsTableView!.rowHeight = 100
        forecastRecordsTableView!.translatesAutoresizingMaskIntoConstraints = false
        forecastRecordsTableView!.dataSource = self
        forecastRecordsTableView!.delegate = self
        forecastRecordsTableView!.register(ForecastRecordTableViewCell.self, forCellReuseIdentifier: "contactCell")
        defineHeaders()
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func defineHeaders() {
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
    
    func setupViews() {
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
    
    func setupTitle() {
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
        return 6
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return headers[section]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if forecastRecords != nil {
            let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath) as! ForecastRecordTableViewCell
            
            let section = forecastRecords![indexPath.section]
            let rowData = section[indexPath.row]
            
            cell.timeLabel.text = rowData.temp
            cell.stateLabel.text = rowData.state
            cell.timeLabel.text = rowData.time
            
            let state = rowData.state
            var currentState: UIImage?
            switch (state as! String) {
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
