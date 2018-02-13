//
//  ApiClient.swift
//  Rocket Launch
//
//  Created by Maxym Sahaydak on 2/13/18.
//  Copyright © 2018 Maxym Sahaydak. All rights reserved.
//

import Foundation
import Alamofire
class ApiClient {
    let baseUrl = "https://launchlibrary.net/1.3/"
    let alamofireManager: AlamofireManager = AlamofireManager.shared

    func get(_ url: String, params: [String: Any]?, headers: [String: String]?, completion: @escaping(DataResponse<Data>) -> Void) {
        let fullUrl: String = buildFullUrl(url)
        alamofireManager.get(fullUrl, params: params, headers: headers) { (response) in
            completion(response)
        }
    }

    func post(_ url: String, params: [String: Any]?, headers: [String: String]?, completion: @escaping(DataResponse<Any>) -> Void) {
        let fullUrl = buildFullUrl(url)
        alamofireManager.post(fullUrl, params: params, headers: headers) { (response) in
            completion(response)
        }
    }

    func get(_ url: String, params: [String: Any]?, headers: [String: String]?, completion: @escaping(DataResponse<Data>, Bool) -> Void) {
        self.get(url, params: params, headers: headers) { (response) in
            completion(response, self.checkIsRepsponseSuccess(response))
        }
    }
    
    func get<T: Codable>(_ url: String, params: [String: Any]?, header: [String: String]?, responseObject: T.Type, completion: @escaping(Any?, Bool, String?)->Void) {
        self.get(url, params: params, headers: header) { (response) in
            do {
                let decoder = JSONDecoder()
                let responseObject = try decoder.decode(T.self, from: response.data!)
                completion(responseObject, true, nil)
            } catch let error {
                completion(nil, false, error.localizedDescription)
            }
        }
    }

    //MARK: - Private functions
    private func buildFullUrl(_ url: String) -> String {
        return baseUrl + url
    }

    private func checkIsRepsponseSuccess(_ response: DataResponse<Data>) -> Bool {
        return false
    }
}
