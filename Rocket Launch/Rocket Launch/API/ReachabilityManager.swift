//
//  ReachableManager.swift
//  Rocket Launch
//
//  Created by Maxym Sahaydak on 2/15/18.
//  Copyright © 2018 Maxym Sahaydak. All rights reserved.
//

import Foundation
import Alamofire
import SwiftMessages
import UIKit

class ReachabilityManager {
    static let shared = ReachabilityManager()
    
    var reachabilityChangedClosure: ((Bool)->Void)?
    
    let alamofireReachabilityManager = Alamofire.NetworkReachabilityManager(host: "www.google.com")
    func startMonitoring() {
        alamofireReachabilityManager?.listener = {status in
            switch status {
            case .notReachable:
                self.reachabilityChangedClosure?(false)
                
            case .unknown:
                print("It is unknown whether the network is reachable")
            case .reachable(.ethernetOrWiFi):
                self.reachabilityChangedClosure?(true)
                 print("The network is reachable over the WiFi connection")
            default:
                break
            }
        }
        
        //
        alamofireReachabilityManager?.startListening()
    }
}
