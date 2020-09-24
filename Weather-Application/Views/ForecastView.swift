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
    
    var forecastRecords: [[Any]]?
    
    let multicoloredLine = MulticoloredView()
    let cityTitle = UILabel()
    var screenHeight: CGFloat = 0.0
    var screenWidth: CGFloat = 0.0
    
    let weekdays = [2: "Monday", 3: "Tuesday", 4: "Wednesday", 5: "Thursday", 6: "Friday", 7: "Saturday", 1: "Sunday"]
    
    var headers = [String]()
    
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
    
    func updateView(with data: [[Any]]) {
        forecastRecords = data
        forecastRecordsTableView?.reloadData()
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
            make.centerX.equalTo(titleView)
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
        var currentHours = Calendar.current.component(.hour, from: Date())
        if section == 0 {
            return (23 - currentHours) / 3
        } else if section == 5 {
            return 8 - (23 - currentHours) / 3
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
            
            cell.tempLabel.text = (forecastRecords![indexPath.row][0] as! String)
            cell.stateLabel.text = forecastRecords![indexPath.row][1] as! String
            
            cell.timeLabel.text = "25:00"
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
        
    
}
