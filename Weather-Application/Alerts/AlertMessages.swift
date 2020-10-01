//
//  AlertMassages.swift
//  Weather-Application
//
//  Created by sdf on 9/29/20.
//  Copyright © 2020 vmodzolevskii. All rights reserved.
//

import Foundation

enum AlertMessages: String {
    case locationIssueTitle = "Location Issue"
    case locationIssueMessage = "Application cannot define current location of your device. Check permission on permission to obtain geolocation"
    
    case invalidURLTitle = "Invalid URL"
    case invalidURLMessage = "Check doc of API on openweathermap.org - URL may be changed"
    case wrongServerStatusTitle = "Wrong server retrieving"
    case wrongServerStatusMessage = "Try to check server operation or API documentation"
    
    case serverRequestErrorTitle = "Server connection error"
    case serverRequestErrorMessage = "Try to check server operation - server may is not available"
    
    case incorrectJSONFormatTitle = "Incorrect format of JSON"
    case incorrectJSONFormatMessage = "Check doc of API on openweathermap.org - JSON format of data may be changed"
}
