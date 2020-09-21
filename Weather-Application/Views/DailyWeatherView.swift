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
    let size = UIScreen.main.bounds
    var screenHeight: CGFloat = 0.0
    
    let titleView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1.0
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.backgroundColor = UIColor.yellow.cgColor
        return view
    }()
    
    let mainInfoView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1.0
        view.layer.backgroundColor = UIColor.green.cgColor
        return view
    }()
    
    let locationTitle = UILabel()
    let temperatureTitle = UILabel()
    
    let detailsInfoView = UIView()
    
    let firstValue = UILabel()
    let secondValue = UILabel()
    let thirdValue = UILabel()
    let fourthValue = UILabel()
    let fivestValue = UILabel()
    
    let shareView = UIView()
    let shareButton = UIButton()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        screenHeight = size.height
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
            make.top.equalTo(titleView.snp.bottom)
            make.height.equalTo(screenHeight / 4)
        }
        
        
        setupDetailsInfoView()
        self.addSubview(detailsInfoView)
        detailsInfoView.backgroundColor = UIColor.red
        detailsInfoView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(mainInfoView.snp.bottom).offset(40)
            make.height.equalTo(screenHeight / 4)
        }
        
        
        shareView.addSubview(shareButton)
        self.addSubview(shareView)
        shareView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(detailsInfoView.snp.bottom)
            make.height.equalTo(screenHeight / 4)
        }
        //shareButton.setTitle("Share", for: .disabled)
        shareButton.setTitle("Share", for: .normal)
        shareButton.backgroundColor = UIColor.black
        
        
        shareButton.snp.makeConstraints { make in
            make.centerX.equalTo(shareView)
        }
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
        
        locationTitle.text = "Location placeholder"
        temperatureTitle.text = "temp placeholder"
        
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
    
    func setupDetailsInfoView() {
        firstValue.text = "42%"
        secondValue.text = "42 mm"
        thirdValue.text = "42 hPa"
        fourthValue.text = "42 km/h"
        fivestValue.text = "SE"
        
        let image1 = UIImage(named: "Placeholder")
        let image2 = UIImage(named: "Placeholder")
        let image3 = UIImage(named: "Placeholder")
        let image4 = UIImage(named: "Placeholder")
        let image5 = UIImage(named: "Placeholder")
        
        let imageView1 = UIImageView(image: image1)
        let imageView2 = UIImageView(image: image2)
        let imageView3 = UIImageView(image: image3)
        let imageView4 = UIImageView(image: image4)
        let imageView5 = UIImageView(image: image5)
        
        detailsInfoView.addSubview(imageView1)
        detailsInfoView.addSubview(imageView2)
        detailsInfoView.addSubview(imageView3)
        detailsInfoView.addSubview(imageView4)
        detailsInfoView.addSubview(imageView5)
        
        detailsInfoView.addSubview(firstValue)
        detailsInfoView.addSubview(secondValue)
        detailsInfoView.addSubview(thirdValue)
        detailsInfoView.addSubview(fourthValue)
        detailsInfoView.addSubview(fivestValue)
        
        
        // first row
        imageView1.snp.makeConstraints { make in
            make.height.width.equalTo(30)
            make.left.equalTo(detailsInfoView).offset(60)
        }
        imageView2.snp.makeConstraints { make in
            make.height.width.equalTo(30)
            make.centerX.equalTo(detailsInfoView)
        }
        imageView3.snp.makeConstraints { make in
            make.height.width.equalTo(30)
            make.right.equalTo(detailsInfoView).offset(-60)
        }
        
        firstValue.snp.makeConstraints { make in
            make.left.equalTo(detailsInfoView).offset(60)
            make.top.equalTo(imageView1.snp.bottom)
        }
        
        secondValue.snp.makeConstraints { make in
            make.centerX.equalTo(detailsInfoView)
            make.top.equalTo(imageView2.snp.bottom)
        }
        
        thirdValue.snp.makeConstraints { make in
            make.right.equalTo(detailsInfoView).offset(-60)
            make.top.equalTo(imageView3.snp.bottom)
        }
        
        // second row
        imageView4.snp.makeConstraints { make in
            make.height.width.equalTo(30)
            make.top.equalTo(firstValue.snp.bottom).offset(20)
            make.left.equalTo(detailsInfoView).offset(120)
        }
        
        imageView5.snp.makeConstraints { make in
            make.height.width.equalTo(30)
            make.top.equalTo(firstValue.snp.bottom).offset(20)
            make.right.equalTo(detailsInfoView).offset(-120)
        }
        
        fourthValue.snp.makeConstraints { make in
            make.top.equalTo(imageView4.snp.bottom)
            make.left.equalTo(detailsInfoView).offset(120)
        }
        
        fivestValue.snp.makeConstraints { make in
            make.top.equalTo(imageView5.snp.bottom)
            make.right.equalTo(detailsInfoView).offset(-120)
        }
    }
    
}
