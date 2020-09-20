//
//  WeatherViewController.swift
//  Weather-Application
//
//  Created by sdf on 9/21/20.
//  Copyright © 2020 vmodzolevskii. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if ConnectivityVerification.isConnectedToInternet {
            
        } else {
            
        }
    }
}
