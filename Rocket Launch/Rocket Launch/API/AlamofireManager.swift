//
//  AlamofireManager.swift
//  Rocket Launch
//
//  Created by Maxym Sahaydak on 2/13/18.
//  Copyright © 2018 Maxym Sahaydak. All rights reserved.
//

import Foundation
import Alamofire

class AlamofireManager: NSObject {
    static let shared = AlamofireManager()
    lazy var alamofireManager: Alamofire.SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 60.0
        configuration.timeoutIntervalForResource = 60.0
        var alamofireManager = Alamofire.SessionManager(configuration: configuration)
        return alamofireManager
    }()


    func get(_ url: String, params: [String: Any]?, headers: [String: String]?, completion: @escaping(DataResponse<Data>) -> Void) {
        print("alamofire get: \(url)")

        alamofireManager.request(url, method: .get, parameters: params, headers: headers).responseData { (response) in
            completion(response)
        }
    }

    func post(_ url: String, params: [String: Any]?, headers: [String: String]?, completion: @escaping(DataResponse<Any>) -> Void) {
        print("alamofire post: \(url)")

        alamofireManager.request(url, method: .post, parameters: params, headers: headers).responseJSON { (response) in
            completion(response)
        }
    }
}

