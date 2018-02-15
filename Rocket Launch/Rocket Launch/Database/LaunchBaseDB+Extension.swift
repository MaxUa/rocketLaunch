//
//  LaunchBaseDB+Extension.swift
//  Rocket Launch
//
//  Created by Maxym Sahaydak on 2/15/18.
//  Copyright © 2018 Maxym Sahaydak. All rights reserved.
//

import Foundation

extension LaunchBaseDB {
    func fill(with baseMode: BaseInfoModel) {
        self.id = Int16(baseMode.id!)
        self.name = baseMode.name
        self.net = baseMode.net
    }
}
