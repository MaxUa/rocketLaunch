//
//  MissionModel.swift
//  Rocket Launch
//
//  Created by Maxym Sahaydak on 2/14/18.
//  Copyright © 2018 Maxym Sahaydak. All rights reserved.
//

import Foundation
struct MissionModel: Codable {
    var id: Int
    var name: String
    var description: String?
    var typeName: String?

    private enum CodingKeys: String, CodingKey {
        case id, name, description, typeName
    }

    
}
