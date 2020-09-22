//
//  MulticoloredView.swift
//  Weather-Application
//
//  Created by sdf on 9/22/20.
//  Copyright © 2020 vmodzolevskii. All rights reserved.
//

import UIKit


class MulticoloredView : UIView {
    
    var customColors: [UIColor]?
    
    let pink = UIColor(red: 240 / 255, green: 148 / 255, blue: 213 / 255, alpha: 1)
    let orange = UIColor(red: 228 / 255, green: 127 / 255, blue: 90 / 255, alpha: 1)
    let green = UIColor(red: 80 / 255, green: 165 / 255, blue: 108 / 255, alpha: 1)
    let blue = UIColor(red: 66 / 255, green: 105 / 255, blue: 174 / 255, alpha: 1)
    let yellow = UIColor(red: 223 / 255, green: 228 / 255, blue: 90 / 255, alpha: 1)
    let red = UIColor(red: 228 / 255, green: 108 / 255, blue: 90 / 255, alpha: 1)

    func fillColors() {
        customColors = [pink, orange, green, blue, yellow, red]
    }
    
    override func draw(_ rect: CGRect) {
        fillColors()
        
        let width = self.bounds.width
        let height = self.bounds.height
        var offsetX = 0
        if let colors = customColors {
            for i in 0..<colors.count {
                let part = CGRect(x: offsetX, y: 0, width: Int(width) / colors.count, height: Int(height))
                colors[i].setFill()
                UIRectFill(part)
                offsetX = offsetX + Int(width) / colors.count
            }
        }
    }
}
