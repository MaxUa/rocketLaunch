//
//  FullInfoModel.swift
//  Rocket Launch
//
//  Created by Maxym Sahaydak on 2/14/18.
//  Copyright © 2018 Maxym Sahaydak. All rights reserved.
//

import Foundation
struct FullInfoModel: LaunchInfoProtocol, Codable {
    var id: Int?
    var name: String?
    var net: String?
    var tbdtime: Int?
    var tbddate: Int?
    var status: Int?

    var windowstart: String?
    var windowend: String?

    var vidURLs: [String]?
    var vidURL: String?
    var infoURLs: [String]?
    var infoURL: String?
    var holdreason: String?

    var location: LaunchLocationModel
    var missions: [MissionModel]
    var rocket: RocketModel

}
