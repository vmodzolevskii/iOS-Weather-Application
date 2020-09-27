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
    private var screenHeight: CGFloat = 0.0
    private var screenWidth: CGFloat = 0.0
    
    // info views
    private let titleView = UIView()
    private let mainInfoView = UIView()
    private let detailsInfoView = UIView()
    // button view
    private let shareView = UIView()
    // multicolored separator
    private let multicoloredLine = MulticoloredView()
    
    // imageview of current weather state
    private var currentStateImageView: UIImageView?
    
    // main weather info
    private let locationTitle = UILabel()
    private let temperatureTitle = UILabel()
    
    // details of the weather
    private var characteristicLabels = [UILabel]()
    private var characteristicViews = [UIImageView]()

    private let shareButton = UIButton()
    
    /// units like mm, pHa, etc
    private var valueUnits = ["%", " mm", " hPa", " km/h", ""]
    
    // MARK: Init
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
    
    // MARK: Setup layout, customize UI elems
    private func setTodayLabel() {
        let todayLabel = UILabel()
        todayLabel.font = UIFont.systemFont(ofSize: 22)
        todayLabel.text = "Today"
        titleView.addSubview(todayLabel)
        
        todayLabel.snp.makeConstraints { make in
            make.center.equalTo(titleView)
        }
    }
    
    private func graySeparator() -> UIView {
        let view = UIView()
        view.layer.borderWidth = 2.0
        view.layer.backgroundColor = UIColor.gray.cgColor
        return view
    }
    
    private func setupViews() {
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
    
    private func customizeButton() {
        shareButton.setTitle("Share", for: .normal)
        shareButton.setTitleColor(UIColor.orange, for: .normal)
        shareButton.backgroundColor = UIColor.white
        shareButton.addTarget(self, action: #selector(onShareButton), for: .touchUpInside)
        
        shareButton.snp.makeConstraints { make in
            make.centerX.equalTo(shareView)
        }
    }
    
    private func customizeLabels() {
        locationTitle.textColor = .blue
        locationTitle.font = .systemFont(ofSize: 26)
        locationTitle.text = "Undefined location"
        temperatureTitle.textColor = .orange
        temperatureTitle.font = .systemFont(ofSize: 24)
        temperatureTitle.text = "-"
    }
    
    private  func setupMainInfoView() {
        let currentState = UIImage(named: "Placeholder")
        self.currentStateImageView = UIImageView(image: currentState)
        guard let stateView = currentStateImageView else { return }
        mainInfoView.addSubview(stateView)
        
        stateView.snp.makeConstraints { make in
            make.height.width.equalTo(screenWidth / 3)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
        }
        
        customizeLabels()
        
        mainInfoView.addSubview(locationTitle)
        mainInfoView.addSubview(temperatureTitle)
        
        locationTitle.snp.makeConstraints { make in
            make.centerX.equalTo(stateView)
            make.top.equalTo(stateView.snp.bottom).offset(10)
        }
        
        temperatureTitle.snp.makeConstraints { make in
            make.centerX.equalTo(mainInfoView)
            make.top.equalTo(locationTitle.snp.bottom)
        }
    }
    
    private func characteristicImageView(with name: String) -> UIImageView {
        let imageView = UIImageView(image: UIImage(named: name))
        return imageView
    }
    
    private func setDetailsImages() {
        characteristicViews.append(characteristicImageView(with: "Humidity"))
        characteristicViews.append(characteristicImageView(with: "Drop"))
        characteristicViews.append(characteristicImageView(with: "Celsius"))
        characteristicViews.append(characteristicImageView(with: "Wind"))
        characteristicViews.append(characteristicImageView(with: "Compass"))
    }
    
    private func setupDefaultValues() {
        setDetailsImages()
        
        for i in 0..<5 {
            let label = UILabel()
            label.text = "-" + valueUnits[i]
            characteristicLabels.append(label)
            
            detailsInfoView.addSubview(characteristicViews[i])
            detailsInfoView.addSubview(characteristicLabels[i])
        }
    }
    
    private func setupDetailsInfoView() {
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
    
    // MARK: Public - Update View
    func updateView(args: [String: String]) {
        // main info updating
        guard let city = args[WeatherArguments.city.rawValue],
            let country = args[WeatherArguments.country.rawValue],
            let temp = args[WeatherArguments.temp.rawValue],
            let state = args[WeatherArguments.state.rawValue] else {
                return
        }
            
        let currentStateImage = updateStateImage(state: state)
        currentStateImageView!.image = currentStateImage
        
        locationTitle.text = city + ", " + country
        let temperatureText = addCelsiusPostfix(temp: temp)
        temperatureTitle.text = temperatureText + " | " + state
        
        // details info updating
        guard let humidity = args[WeatherArguments.humidity.rawValue],
            let clouds = args[WeatherArguments.clouds.rawValue],
            let pressure = args[WeatherArguments.pressure.rawValue],
            let speed = args[WeatherArguments.speed.rawValue],
            let direction = args[WeatherArguments.direction.rawValue] else {
                return
        }
        
        guard let windDegree = Int(direction) else { return }
        let degree = defineWindDirection(degree: windDegree)
        let details = [humidity, clouds, pressure, speed, degree]
        
        for i in 0..<characteristicLabels.count {
            characteristicLabels[i].text = (details[i]) + (valueUnits[i])
        }
    }
    
    private func addCelsiusPostfix(temp: String) -> String {
        return NSString(format: temp + "%@" as NSString, "\u{00B0}") as String
    }
    
    // MARK: Defining values
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
    
    private func defineWindDirection(degree: Int) -> String {
        var direction = ""
        switch degree {
        case (0..<23): direction = "N"
        case (338..<360): direction = "N"
        case 23..<68: direction = "NE"
        case 68..<113: direction = "E"
        case 113..<168: direction = "SE"
        case 168..<203: direction = "S"
        case 203..<248: direction = "SW"
        case 248..<294: direction = "W"
        case 294..<338: direction = "NW"
        default: break
        }
        return direction
    }
    
}
