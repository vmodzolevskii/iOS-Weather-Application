//
//  MulticoloredView.swift
//  Weather-Application
//
//  Created by sdf on 9/22/20.
//  Copyright © 2020 vmodzolevskii. All rights reserved.
//

import UIKit


class MulticoloredView : UIView {
    private var customColors: [UIColor?]?
    
    private let pink = UIColor(named: "Pink")
    private let orange = UIColor(named: "Orange")
    private let green = UIColor(named: "Green")
    private let blue = UIColor(named: "Blue")
    private let yellow = UIColor(named: "Yellow")
    private let red = UIColor(named: "Red")

    private func fillColors() {
        customColors = [pink, orange, green, blue, yellow, red]
    }
    
    override func draw(_ rect: CGRect) {
        fillColors()
        
        let width = self.bounds.width
        let height = self.bounds.height
        var offsetX = 0
        if let colors = customColors {
            for color in colors {
                let part = CGRect(x: offsetX, y: 0,
                                  width: Int(width) / colors.count,
                                  height: Int(height))
                
                guard let colour = color else { return }
                colour.setFill()
                UIRectFill(part)
                offsetX = offsetX + Int(width) / colors.count
            }
        }
    }
}
