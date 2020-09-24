//
//  ForecastRecordTableCell.swift
//  Weather-Application
//
//  Created by sdf on 9/23/20.
//  Copyright © 2020 vmodzolevskii. All rights reserved.
//

import UIKit
import SnapKit

class ForecastRecordTableViewCell: UITableViewCell {
    let weatherStateImageView: UIImageView = {
        let image = UIImage(named: "Placeholder")
        let targetSize = CGSize(width: 80, height: 80)
        let scaledImage = image!.scalePreservingAspectRatio(targetSize: targetSize)
        let imageView = UIImageView()
        imageView.image = scaledImage
        return imageView
    }()
    
    var timeLabel = UILabel()
    var stateLabel = UILabel()
    var tempLabel = UILabel()
    var stateImage: UIImage?
    
    func updateStateImage() {
        let targetSize = CGSize(width: 80, height: 80)
        stateImage = stateImage!.scalePreservingAspectRatio(targetSize: targetSize)
        weatherStateImageView.image = stateImage
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(weatherStateImageView)
        self.contentView.addSubview(timeLabel)
        self.contentView.addSubview(stateLabel)
        self.contentView.addSubview(tempLabel)
        
        // test
        tempLabel.text = NSString(format:"23%@", "\u{00B0}") as String
        stateLabel.text = "Cloudy"
        //timeLabel.text = "13:00"
        //
        
        customizeLabels()
        
        weatherStateImageView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.centerY.equalToSuperview()
        }
        
        timeLabel.snp.makeConstraints { make in
            make.left.equalTo(weatherStateImageView.snp.right).offset(40)
            make.top.equalToSuperview().offset(20)
        }
        
        stateLabel.snp.makeConstraints { make in
            make.left.equalTo(weatherStateImageView.snp.right).offset(40)
            make.top.equalTo(timeLabel.snp.bottom).offset(10)
        }
        
        tempLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-10)
            make.centerY.equalToSuperview()
        }
     }
    
    func customizeLabels() {
        stateLabel.font = UIFont.systemFont(ofSize: 18)
        timeLabel.font = UIFont.systemFont(ofSize: 18)
        
        tempLabel.font = UIFont.systemFont(ofSize: 60)
        tempLabel.textColor = .blue
    }

     required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
}
