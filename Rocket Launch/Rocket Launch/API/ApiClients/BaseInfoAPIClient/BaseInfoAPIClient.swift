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
        get("launch", params: ["next": 50], header: nil, responseObject: LaunchesModel.self) { (responseObject, isSuccess, errorMessage) in
            if isSuccess {
                guard let launchResponse = responseObject as? LaunchesModel else {completion(nil, true, "Something went wrong"); return}
                completion(launchResponse.launches, true, nil)
            } else {
                completion(nil, false, errorMessage)
            }
        }
    }

    func getLaunchFullInfo(with id: Int, completion: @escaping(Any, Bool, String?) -> Void) {
        get("launch", params: ["id": id, "mode":"verbose"], header: nil, responseObject: FullInfoModel.self) { (responseObject, isSuccess, errorMessage) in
            let fullInfoModel = responseObject as! FullInfoModel
            print(fullInfoModel)
        }
    }
}
