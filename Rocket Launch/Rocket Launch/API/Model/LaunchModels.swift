//
//  LaunchModel.swift
//  Rocket Launch
//
//  Created by Maxym Sahaydak on 2/14/18.
//  Copyright © 2018 Maxym Sahaydak. All rights reserved.
//

import Foundation
protocol LaunchesInfoProtocol {
    var status: String? {get set}
    var errorMessage: String? {get set}
    var total: Int? {get set}
    var offset: Int? {get set}
    var count: Int? {get set}
}

struct FullInfoLaunches: Codable, LaunchesInfoProtocol {
    var status: String?
    var errorMessage: String?
    var total: Int?
    var offset: Int?
    var count: Int?

    var launches: [FullInfoModel]?
    
}

public struct BaseInfoLaunches: Codable, LaunchesInfoProtocol {
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
