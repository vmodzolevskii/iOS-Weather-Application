//
//  ConnectivityVerification.swift
//  Weather-Application
//
//  Created by sdf on 9/21/20.
//  Copyright © 2020 vmodzolevskii. All rights reserved.
//

import Foundation
import Alamofire

class ConnectivityVerification {
    class var isConnectedToInternet: Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}
