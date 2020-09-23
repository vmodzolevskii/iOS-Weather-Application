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
        let targetSize = CGSize(width: 70, height: 70)
        let scaledImage = image!.scalePreservingAspectRatio(targetSize: targetSize)
        let imageView = UIImageView()
        imageView.image = scaledImage
        return imageView
    }()
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubview(weatherStateImageView)
//        weatherStateImageView.snp.makeConstraints { make in
//            make.left.equalToSuperview()
//        }
     }

     required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
}
