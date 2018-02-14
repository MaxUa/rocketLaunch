//
//  File.swift
//  Rocket Launch
//
//  Created by Maxym Sahaydak on 2/14/18.
//  Copyright © 2018 Maxym Sahaydak. All rights reserved.
//

import Foundation
struct LaunchLocationModel: Codable {
    var pads: [LaunchPadModel]
    var id: Int
    var name: String
    var infoURL: String?
    var wikiURL: String?
    var countryCode: String

    private enum CodingKeys: String, CodingKey {
        case id, name, infoURL, wikiURL, countryCode, pads
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.infoURL = try container.decodeIfPresent(String.self, forKey: .infoURL)
        self.wikiURL = try container.decodeIfPresent(String.self, forKey: .wikiURL)
        self.countryCode = try container.decode(String.self, forKey: .countryCode)
        self.pads = try container.decode([LaunchPadModel].self, forKey: .pads)
    }
}

struct LaunchPadModel: Codable {
    var id: Int
    var name: String
    var mapURL: String
    var latitude: Float
    var longtitude: Float

    private enum CodingKeys: String, CodingKey {
        case id, name, mapURL, latitude, longtitude
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.mapURL = try container.decode(String.self, forKey: .mapURL)
        self.latitude = try container.decode(Float.self, forKey: .latitude)
        self.longtitude = try container.decode(Float.self, forKey: .longtitude)
    }
}
