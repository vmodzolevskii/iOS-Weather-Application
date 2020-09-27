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
    private let widthHeightImageValue = 80
    
    private let weatherStateImageView: UIImageView = {
        guard let image = UIImage(named: "Placeholder") else { return UIImageView() }
        let scaledImage = image.scalePreservingAspectRatio(targetSize: CGSize(width: 80,  height: 80))
        let imageView = UIImageView()
        imageView.image = scaledImage
        return imageView
    }()
    
    var timeLabel = UILabel()
    var stateLabel = UILabel()
    var tempLabel = UILabel()
    var stateImage: UIImage?

    // MARK: Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        customizeLabels()
    }
    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
    
    // MARK: Public methods
    func updateStateImage() {
        let targetSize = CGSize(width: 80, height: 80)
        guard let image = stateImage else { return }
        stateImage = image.scalePreservingAspectRatio(targetSize: targetSize)
        weatherStateImageView.image = stateImage
    }
    
    // MARK: Private methods
    private func addSubviews() {
        self.contentView.addSubview(weatherStateImageView)
        self.contentView.addSubview(timeLabel)
        self.contentView.addSubview(stateLabel)
        self.contentView.addSubview(tempLabel)
        
        setConstraints()
    }
    
    private func setConstraints() {
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
    
    private func customizeLabels() {
        stateLabel.font = UIFont.systemFont(ofSize: 18)
        timeLabel.font = UIFont.systemFont(ofSize: 18)
        
        tempLabel.font = UIFont.systemFont(ofSize: 60)
        tempLabel.textColor = .blue
    }
}
