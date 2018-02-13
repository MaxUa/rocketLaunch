//
//  File.swift
//  Rocket Launch
//
//  Created by Maxym Sahaydak on 2/13/18.
//  Copyright © 2018 Maxym Sahaydak. All rights reserved.
//

/*
 "id": 1425,
 "name": "Soyuz 2.1a | Progress MS-08 (69P)",
 "net": "February 13, 2018 08:13:33 UTC",
 "tbdtime": 0,
 "tbddate": 0
 */

import Foundation
public struct BaseInfoModel: Codable {
    var id: Int?
    var name: String?
    var net: String?
    var tbdtime: Int?
    var tbddate: Int?
    var status: Int?

    private enum CodingKeys:String, CodingKey {
        case id, name, net, tbdtime, tbddate, status
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.net = try container.decode(String.self, forKey: .net)
        self.tbdtime = try container.decode(Int.self, forKey: .tbdtime)
        self.tbddate = try container.decode(Int.self, forKey: .tbddate)
        self.status = try container.decodeIfPresent(Int.self, forKey: .status)
    }
}

public struct LaunchesModel: Codable {
    var status: String?
    var errorMessage: String?
    var launches: [BaseInfoModel]?
    var total: Int?
    var offset: Int?
    var count: Int?

    private enum CodingKeys: String, CodingKey {
        case launches, total, offset, count, status, errorMessage = "msg"
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.launches = try container.decodeIfPresent([BaseInfoModel].self, forKey: .launches)
        self.total = try container.decodeIfPresent(Int.self, forKey: .total)
        self.offset = try container.decodeIfPresent(Int.self, forKey: .offset)
        self.count = try container.decode(Int.self, forKey: .count)
        self.status = try container.decodeIfPresent(String.self, forKey: .status)
        self.errorMessage = try container.decodeIfPresent(String.self, forKey: .errorMessage)
    }
}
