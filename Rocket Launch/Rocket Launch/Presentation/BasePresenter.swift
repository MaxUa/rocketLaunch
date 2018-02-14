//
//  BasePresenter.swift
//  Rocket Launch
//
//  Created by Maxym Sahaydak on 2/14/18.
//  Copyright © 2018 Maxym Sahaydak. All rights reserved.
//

import Foundation

class BasePresenter: NSObject {
    var loadingStatusUpdated: (()->())?

    var isLoading: Bool = false {
        didSet {
            self.loadingStatusUpdated?()
        }
    }
}
