//
//  RocketModel.swift
//  Rocket Launch
//
//  Created by Maxym Sahaydak on 2/14/18.
//  Copyright © 2018 Maxym Sahaydak. All rights reserved.
//

import Foundation
struct RocketModel: Codable {
    var id: Int
    var name: String
    var configuration: String
    var familyname: String
    var wikiURL: String?
    var infoURL: String?
}
