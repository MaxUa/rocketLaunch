//
//  BaseInfoAPIClient.swift
//  Rocket Launch
//
//  Created by Maxym Sahaydak on 2/13/18.
//  Copyright © 2018 Maxym Sahaydak. All rights reserved.
//

import Foundation
class BaseInfoAPIClient: ApiClient {
    func getUpcomingLaunches(completion: @escaping ([BaseInfoModel]?, Bool, String?) -> Void) {
        get("launch", params: ["next": 50], header: nil) { (model: BaseInfoLaunches?, isSucces, errorMessage) in
            guard let _model = model else {completion(nil, false, "Something went wrong"); return}
            completion(_model.launches, true, nil)
        }
    }

    func getLaunchFullInfo(with id: Int, completion: @escaping(FullInfoModel?, Bool, String?) -> Void) {
        get("launch", params: ["id": id, "mode":"verbose"], header: nil) { (model:FullInfoLaunches?, isSuccess, errorMessage) in
            guard let _model = model,
                let launches = _model.launches,
                let launch = launches.first else {completion(nil, false, "Something went wrong"); return}

            completion(launch, true, nil)
            
        }
    }
}
