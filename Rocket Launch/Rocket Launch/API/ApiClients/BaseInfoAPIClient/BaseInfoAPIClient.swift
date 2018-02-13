//
//  BaseInfoAPIClient.swift
//  Rocket Launch
//
//  Created by Maxym Sahaydak on 2/13/18.
//  Copyright © 2018 Maxym Sahaydak. All rights reserved.
//

import Foundation
class BaseInfoAPIClient: ApiClient {
    func getUpcomingLaunches(completion: @escaping ([Any]?, Bool, String?) -> Void) {
//        get("launch", params: ["next": 5], headers: nil) { (response, success) in
//            do {
//                let decoder = JSONDecoder.init()
//                let lauchesResponse = try decoder.decode(LaunchesModel.self, from: response.data!)
//
//                if let status = lauchesResponse.status, status == "error" {
//                    completion(nil, false, lauchesResponse.errorMessage)
//                } else {
//                    completion(lauchesResponse.launches, true, nil)
//                }
//            } catch let error {
//                print("decode error: \(error.localizedDescription)")
//                completion(nil, false, error.localizedDescription)
//            }
//        }


        get("launch", params: ["next": 5], header: nil, responseObject: LaunchesModel.self) { (responseObject, isSuccess, errorMessage) in
            if isSuccess {
                guard let launchResponse = responseObject as? LaunchesModel else {completion(nil, true, "Something went wrong"); return}
                completion(launchResponse.launches, true, nil)
            } else {
                completion(nil, false, errorMessage)
            }
        }
    }
}
