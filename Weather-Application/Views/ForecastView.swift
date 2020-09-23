//
//  ForecastView.swift
//  Weather-Application
//
//  Created by sdf on 9/22/20.
//  Copyright © 2020 vmodzolevskii. All rights reserved.
//

import UIKit
import SnapKit

class ForecastView: UIView {
    let cityTitle = UILabel()
    var screenHeight: CGFloat = 0.0
    var screenWidth: CGFloat = 0.0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        let size = UIScreen.main.bounds
        screenHeight = size.height
        screenWidth = size.width
        
        setupTitle()
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
        
        
        let line = MulticoloredView()
        line.setNeedsDisplay()
        self.addSubview(line)
        line.snp.makeConstraints { make in
            make.height.equalTo(2)
            make.width.equalTo(screenWidth)
            make.top.equalTo(titleView.snp.bottom)
        }
    }
}
