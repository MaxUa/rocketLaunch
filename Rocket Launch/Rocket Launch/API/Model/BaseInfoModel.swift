//
//  File.swift
//  Rocket Launch
//
//  Created by Maxym Sahaydak on 2/13/18.
//  Copyright © 2018 Maxym Sahaydak. All rights reserved.
//


import Foundation
protocol LaunchInfoProtocol {
    var id: Int? {get set}
    var name: String? {get set}
    var net: String? {get set}
    var tbdtime: Int? {get set}
    var tbddate: Int? {get set}
    var status: Int? {get set}
}

public struct BaseInfoModel: Codable, LaunchInfoProtocol {
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
