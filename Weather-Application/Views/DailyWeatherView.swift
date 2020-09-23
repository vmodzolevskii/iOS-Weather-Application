//
//  DailyWeatherView.swift
//  Weather-Application
//
//  Created by sdf on 9/21/20.
//  Copyright © 2020 vmodzolevskii. All rights reserved.
//

import UIKit
import SnapKit

class DailyWeatherView: UIView {
    public var shareWeatherAction: (() -> Void)?
    
    // to determine sizes of views
    var screenHeight: CGFloat = 0.0
    var screenWidth: CGFloat = 0.0
    
    // info views
    let titleView = UIView()
    let mainInfoView = UIView()
    let detailsInfoView = UIView()
    // button view
    let shareView = UIView()
    // multicolored separator
    let multicoloredLine = MulticoloredView()
    
    // main weather info
    let locationTitle = UILabel()
    let temperatureTitle = UILabel()
    
    // details of the weather
    var characteristicLabels = [UILabel]()
    var characteristicViews = [UIImageView]()

    let shareButton = UIButton()
    
    // units like mm, pHa, etc
    var valueUnits = ["%", " mm", " hPa", " km/h", ""]
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        let size = UIScreen.main.bounds
        screenHeight = size.height
        screenWidth = size.width
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setTodayLabel() {
        let todayLabel = UILabel()
        todayLabel.font = UIFont.systemFont(ofSize: 22)
        todayLabel.text = "Today"
        titleView.addSubview(todayLabel)
        
        todayLabel.snp.makeConstraints { make in
            make.center.equalTo(titleView)
        }
    }
    
    func graySeparator() -> UIView {
        let view = UIView()
        view.layer.borderWidth = 2.0
        view.layer.backgroundColor = UIColor.gray.cgColor
        return view
    }
    
    func setupViews() {
        // today label
        self.addSubview(titleView)
        setTodayLabel()
    
        titleView.snp.makeConstraints { make in
            make.height.equalTo(screenHeight / 15)
            make.left.top.right.equalToSuperview()
        }
        
        // multicolored separator
        self.addSubview(multicoloredLine)
        multicoloredLine.snp.makeConstraints { make in
            make.height.equalTo(2)
            make.left.right.equalToSuperview()
            make.top.equalTo(titleView.snp.bottom)
        }
        
        // main weather information
        self.addSubview(mainInfoView)
        setupMainInfoView()
        mainInfoView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(multicoloredLine.snp.bottom).offset(screenHeight / 16)
            make.height.equalTo(screenHeight / 4)
        }
        
        // separator
        let firstSeparator = graySeparator()
        self.addSubview(firstSeparator)
        firstSeparator.snp.makeConstraints { make in
            make.width.equalTo(screenWidth / 3)
            make.height.equalTo(1)
            make.centerX.equalToSuperview()
            make.top.equalTo(temperatureTitle.snp.bottom).offset(10)
        }
        
        // weather details
        self.addSubview(detailsInfoView)
        setupDetailsInfoView()
        detailsInfoView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(firstSeparator.snp.bottom).offset(screenHeight / 20)
            make.height.equalTo(screenHeight / 5)
        }
        
        // separator
        let secondSeparator = graySeparator()
        self.addSubview(secondSeparator)
        secondSeparator.snp.makeConstraints { make in
            make.width.equalTo(screenWidth / 3)
            make.height.equalTo(1)
            make.centerX.equalToSuperview()
            make.top.equalTo(characteristicLabels[3].snp.bottom).offset(screenHeight / 20)
        }
        
        // sharing
        shareView.addSubview(shareButton)
        self.addSubview(shareView)
        shareView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(secondSeparator.snp.bottom).offset(screenHeight / 15)
            make.height.equalTo(screenHeight / 4)
        }
        
        customizeButton()
    }
    
    @objc func onShareButton() {
        self.shareWeatherAction?()
    }
    
    func customizeButton() {
        shareButton.setTitle("Share", for: .normal)
        shareButton.setTitleColor(UIColor.orange, for: .normal)
        shareButton.backgroundColor = UIColor.white
        shareButton.addTarget(self, action: #selector(onShareButton), for: .touchUpInside)
        
        shareButton.snp.makeConstraints { make in
            make.centerX.equalTo(shareView)
        }
    }
    
    func customizeLabels() {
        locationTitle.textColor = .orange
        locationTitle.font = .systemFont(ofSize: 26)
        locationTitle.text = "City, Country"
        temperatureTitle.textColor = .orange
        temperatureTitle.font = .systemFont(ofSize: 24)
        temperatureTitle.text = "Degree | State"
    }
    
    func setupMainInfoView() {
        let image = UIImage(named: "Placeholder")
        let imageView = UIImageView(image: image)
        mainInfoView.addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.height.width.equalTo(screenWidth / 3)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
        }
        
        customizeLabels()
        
        mainInfoView.addSubview(locationTitle)
        mainInfoView.addSubview(temperatureTitle)
        
        locationTitle.snp.makeConstraints { make in
            make.centerX.equalTo(imageView)
            make.top.equalTo(imageView.snp.bottom).offset(10)
        }
        
        temperatureTitle.snp.makeConstraints { make in
            make.centerX.equalTo(mainInfoView)
            make.top.equalTo(locationTitle.snp.bottom)
        }
    }
    
    func characteristicImageView(with name: String) -> UIImageView {
        let image = UIImage(named: name)
        let imageView = UIImageView(image: image)
        return imageView
    }
    
    func setupDefaultValues() {
        for i in 0..<5 {
            let label = UILabel()
            label.text = "-" + valueUnits[i]
            characteristicLabels.append(label)
            characteristicViews.append(characteristicImageView(with: "Placeholder"))
            
            detailsInfoView.addSubview(characteristicViews[i])
            detailsInfoView.addSubview(characteristicLabels[i])
        }
    }
    
    func setupDetailsInfoView() {
        setupDefaultValues()
        
        let iconWidthHeight = screenWidth / 12
        
        // first row of weather's details
        // views
        characteristicViews[0].snp.makeConstraints { make in
            make.width.height.equalTo(iconWidthHeight)
            make.left.equalTo(screenWidth / 5)
        }
        
        characteristicViews[1].snp.makeConstraints { make in
            make.width.height.equalTo(iconWidthHeight)
            make.left.equalTo(screenWidth / 2 - iconWidthHeight / 2)
        }
        
        characteristicViews[2].snp.makeConstraints { make in
            make.width.height.equalTo(iconWidthHeight)
            make.left.equalTo(screenWidth * 4 / 5 - iconWidthHeight)
        }
        
        // labels
        characteristicLabels[0].snp.makeConstraints { make in
            make.centerX.equalTo(screenWidth / 5 + iconWidthHeight / 2)
            make.top.equalTo(characteristicViews[0].snp.bottom).offset(5)
        }
        
        characteristicLabels[1].snp.makeConstraints { make in
            make.centerX.equalTo(screenWidth / 2)
            make.top.equalTo(characteristicViews[1].snp.bottom).offset(5)
        }
        
        characteristicLabels[2].snp.makeConstraints { make in
            make.centerX.equalTo(screenWidth * 4 / 5 - iconWidthHeight / 2)
            make.top.equalTo(characteristicViews[2].snp.bottom).offset(5)
        }
        
        
        // second row
        // views
        characteristicViews[3].snp.makeConstraints { make in
            make.width.height.equalTo(iconWidthHeight)
            make.left.equalTo(screenWidth / 3 - iconWidthHeight / 2)
            make.top.equalTo(characteristicLabels[0].snp.bottom).offset(screenHeight / 20)
        }
        
        characteristicViews[4].snp.makeConstraints { make in
            make.width.height.equalTo(iconWidthHeight)
            make.centerX.equalTo(screenWidth * 2 / 3 - iconWidthHeight / 2)
            make.top.equalTo(characteristicLabels[0].snp.bottom).offset(screenHeight / 20)
        }
        
        // labels
        characteristicLabels[3].snp.makeConstraints { make in
            make.centerX.equalTo(screenWidth / 3)
            make.top.equalTo(characteristicViews[3].snp.bottom).offset(5)
        }
        
        characteristicLabels[4].snp.makeConstraints { make in
            make.centerX.equalTo(screenWidth * 2 / 3 - iconWidthHeight / 2)
            make.top.equalTo(characteristicViews[4].snp.bottom).offset(5)
        }
    }
    
    func updateView(parameters: [String: Any]) {
        // main info updating
        let locationText = (parameters[DataModel.city.rawValue] as! String) + ", " + (parameters[DataModel.country.rawValue] as! String)
        
        locationTitle.text = locationText
        temperatureTitle.text = parameters[DataModel.temp.rawValue] as! String
        
        //details info updating
        let details = parameters[DataModel.details.rawValue] as! [String]
        for i in 0..<characteristicLabels.count {
            characteristicLabels[i].text = (details[i] as! String) + (valueUnits[i])
        }
    }
    
}
