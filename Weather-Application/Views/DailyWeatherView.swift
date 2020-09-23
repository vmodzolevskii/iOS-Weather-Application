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
    
    var screenHeight: CGFloat = 0.0
    var screenWidth: CGFloat = 0.0
    
    let titleView = UIView()
    let mainInfoView = UIView()
    
    let locationTitle = UILabel()
    let temperatureTitle = UILabel()
    
    let detailsInfoView = UIView()
    
    // details of the weather
    var characteristicLabels = [UILabel]()
    
    let shareView = UIView()
    let shareButton = UIButton()
    
    var valueUnits = [String]()
    
    let viewSeparator: UIView = {
        let view = UIView()
        view.layer.borderWidth = 2.0
        view.layer.backgroundColor = UIColor.gray.cgColor
        return view
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let size = UIScreen.main.bounds
        screenHeight = size.height
        screenWidth = size.width
        self.backgroundColor = .white
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        self.addSubview(titleView)
        
        let todayLabel = UILabel()
        todayLabel.font = UIFont.systemFont(ofSize: 22)
        todayLabel.text = "Today"
        self.addSubview(todayLabel)
        
        titleView.snp.makeConstraints { make in
            make.height.equalTo(screenHeight / 15)
            make.left.top.right.equalToSuperview()
        }
        
        todayLabel.snp.makeConstraints { make in
            make.center.equalTo(titleView)
        }
        
        setupMainInfoView()
        self.addSubview(mainInfoView)
        mainInfoView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(titleView.snp.bottom).offset(screenHeight / 16)
            make.height.equalTo(screenHeight / 4)
        }
        
        // separator
        self.addSubview(viewSeparator)
        viewSeparator.snp.makeConstraints { make in
            make.width.equalTo(screenWidth / 3)
            make.height.equalTo(1)
            make.centerX.equalToSuperview()
            make.top.equalTo(mainInfoView.snp.bottom).offset(4)
        }
        
        
        setupDetailsInfoView()
        self.addSubview(detailsInfoView)
        
        detailsInfoView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(mainInfoView.snp.bottom).offset(40)
            make.height.equalTo(screenHeight / 4)
        }
        
        // separator
        let oneMoreSeparator = UIView()
        oneMoreSeparator.layer.borderWidth = 2.0
        oneMoreSeparator.layer.backgroundColor = UIColor.gray.cgColor
        
        self.addSubview(oneMoreSeparator)
        oneMoreSeparator.snp.makeConstraints { make in
            make.width.equalTo(screenWidth / 3)
            make.height.equalTo(1)
            make.centerX.equalToSuperview()
            make.top.equalTo(detailsInfoView.snp.bottom).offset(4)
        }
        
        
        shareView.addSubview(shareButton)
        self.addSubview(shareView)
        shareView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(oneMoreSeparator.snp.bottom).offset(5)
            make.height.equalTo(screenHeight / 4)
        }
        
        shareButton.setTitle("Share", for: .normal)
        shareButton.setTitleColor(UIColor.orange, for: .normal)
        shareButton.backgroundColor = UIColor.white
        shareButton.addTarget(self, action: #selector(onShareButton), for: .touchUpInside)
        
        
        shareButton.snp.makeConstraints { make in
            make.centerX.equalTo(shareView)
        }
    }
    
    @objc func onShareButton() {
        self.shareWeatherAction?()
    }
    
    func setupMainInfoView() {
        let image = UIImage(named: "Placeholder")
        let imageView = UIImageView(image: image)
        mainInfoView.addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.height.equalTo(150)
            make.width.equalTo(150)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
        }
        
        locationTitle.font = UIFont.systemFont(ofSize: 18)
        locationTitle.text = "City, Country"
        temperatureTitle.font = UIFont.systemFont(ofSize: 18)
        temperatureTitle.text = "Degree | State"
        
        mainInfoView.addSubview(locationTitle)
        mainInfoView.addSubview(temperatureTitle)
        
        locationTitle.snp.makeConstraints { make in
            make.centerX.equalTo(mainInfoView)
            make.top.equalTo(imageView.snp.bottom)
        }
        
        temperatureTitle.snp.makeConstraints { make in
            make.centerX.equalTo(mainInfoView)
            make.top.equalTo(locationTitle.snp.bottom)
        }
    }
    
    func pushUnits() {
        valueUnits.append("%")
        valueUnits.append(" mm")
        valueUnits.append(" hPa")
        valueUnits.append(" km/h")
        valueUnits.append("")
    }
    
    func characteristicImageView(with name: String) -> UIImageView {
        let image = UIImage(named: name)
        let imageView = UIImageView(image: image)
        return imageView
    }
    
    func setupDetailsInfoView() {
        pushUnits()
        
        var characteristicLabels = [UILabel]()
        var characteristicViews = [UIImageView]()
        
        for i in 0..<5 {
            let label = UILabel()
            label.text = "-" + valueUnits[i]
            characteristicLabels.append(label)
            
            characteristicViews.append(characteristicImageView(with: "Placeholder"))
            
            detailsInfoView.addSubview(characteristicViews[i])
            detailsInfoView.addSubview(characteristicLabels[i])
        }
        
        let iconWidthHeight = screenWidth / 12
        
        // first row of weather's details
        makeImageViewConstraints(for: characteristicViews[0], width: Int(iconWidthHeight), height: Int(iconWidthHeight), topConstraint: nil, verticalOffset: nil, leftConstraint: detailsInfoView, horizontalOffset: Int(screenWidth) / 5)
        
        makeImageViewConstraints(for: characteristicViews[1], width: Int(iconWidthHeight), height: Int(iconWidthHeight), topConstraint: nil, verticalOffset: nil, leftConstraint: detailsInfoView, horizontalOffset: nil)
        
        makeImageViewConstraints(for: characteristicViews[2], width: Int(iconWidthHeight), height: Int(iconWidthHeight), topConstraint: nil, verticalOffset: nil, leftConstraint: detailsInfoView, horizontalOffset: Int(screenWidth) * 4 / 5 - Int(iconWidthHeight))
        
        makeImageViewConstraints(for: characteristicLabels[0], width: nil, height: nil, topConstraint: characteristicViews[0], verticalOffset: 0, leftConstraint: detailsInfoView, horizontalOffset: Int(screenWidth) / 5)
        
        makeImageViewConstraints(for: characteristicLabels[1], width: nil, height: nil, topConstraint: characteristicViews[1], verticalOffset: 0, leftConstraint: detailsInfoView, horizontalOffset: nil)
        
        makeImageViewConstraints(for: characteristicLabels[2], width: nil, height: nil, topConstraint: characteristicViews[2], verticalOffset: 0, leftConstraint: detailsInfoView, horizontalOffset: Int(screenWidth) * 4 / 5 - Int(iconWidthHeight))
        
        
        // second row
        makeImageViewConstraints(for: characteristicViews[3], width: Int(iconWidthHeight), height: Int(iconWidthHeight), topConstraint: characteristicViews[0], verticalOffset: Int(screenHeight) / 20, leftConstraint: detailsInfoView, horizontalOffset: Int(screenWidth) * 1 / 3)
        
        makeImageViewConstraints(for: characteristicViews[4], width: Int(iconWidthHeight), height: Int(iconWidthHeight), topConstraint: characteristicViews[0], verticalOffset: Int(screenHeight) / 20, leftConstraint: detailsInfoView, horizontalOffset: (Int(screenWidth) * 2 / 3 - Int(iconWidthHeight)))
        
        makeImageViewConstraints(for: characteristicLabels[3], width: nil, height: nil, topConstraint: characteristicViews[3], verticalOffset: 0, leftConstraint: detailsInfoView, horizontalOffset: (Int(screenWidth) * 1 / 3 - Int(iconWidthHeight)))
        
        makeImageViewConstraints(for: characteristicLabels[4], width: nil, height: nil, topConstraint: characteristicViews[4], verticalOffset: 0, leftConstraint: detailsInfoView, horizontalOffset: (Int(screenWidth) * 2 / 3 - Int(iconWidthHeight)))
    }
    
    func makeImageViewConstraints(for view: UIView, width: Int?, height: Int?, topConstraint: UIView?, verticalOffset: Int?, leftConstraint: UIView, horizontalOffset: Int?) {
        view.snp.makeConstraints { make in
            if let widthValue = width, let heightValue = height {
                make.height.equalTo(heightValue)
                make.width.equalTo(widthValue)
            }
            if let topView = topConstraint, let vertOffset = verticalOffset {
                make.top.equalTo(topView.snp.bottom).offset(vertOffset)
            }
            if let horOffset = horizontalOffset {
                make.left.equalTo(leftConstraint).offset(horOffset)
            } else {
                make.centerX.equalTo(leftConstraint)
            }
        }
    }
    
    func updateView(parameters: [String: Any]) {
        // main info updating
        let locationText = (parameters[DataModel.city.rawValue] as! String) + ", " + (parameters[DataModel.country.rawValue] as! String)
        locationTitle.text = locationText
        temperatureTitle.text = parameters[DataModel.temp.rawValue] as! String
        
        //details info updating
        let array = parameters[DataModel.details.rawValue]
        
    }
    
}
