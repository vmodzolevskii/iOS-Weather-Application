//
//  AlertManager.swift
//  Weather-Application
//
//  Created by sdf on 9/21/20.
//  Copyright © 2020 vmodzolevskii. All rights reserved.
//

import UIKit

class AlertManager {
    func absenceConnectionAlert() -> UIAlertController {
        let connectionAlert = UIAlertController(
                                    title: "Mobile Data is Turned Off",
                                    message: "Turn on mobile data or use Wi-Fi to access data.",
                                    preferredStyle: .alert)

        let settingsAction = UIAlertAction(title: "Settings",
                                           style: .cancel) { (_) -> Void in
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString)
                else { return }

            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl, completionHandler: nil)
            }
        }
        
        connectionAlert.addAction(settingsAction)
        connectionAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        return connectionAlert
    }
    
    func exceptionAlert(with alertTitle: String, alertMessage: String) -> UIAlertController {
        let exceptionAlert = UIAlertController(
                    title: alertTitle,
                    message: alertMessage,
                    preferredStyle: .alert)
        
        exceptionAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        return exceptionAlert
    }
}
