//
//  LaunchDetailVCPresenter.swift
//  Rocket Launch
//
//  Created by Maxym Sahaydak on 2/14/18.
//  Copyright © 2018 Maxym Sahaydak. All rights reserved.
//

import Foundation

class LaunchDetailPresenter: BasePresenter {
    weak var view: LaunchDetailVC?
    //MARK: - Fetching methos
    func loadAlunchDetail(for launchId: Int) {
        self.isLoading = true
        BaseInfoAPIClient().getLaunchFullInfo(with: launchId) { (response, isSuccess, errorMessage) in
            if let _response = response {
                self.titleStr = _response.name ?? ""
                self.timeStr = _response.net ?? ""

                if let mission = _response.missions.first {
                    self.missionDetailStr = mission.description
                    self.missionTitleStr = mission.name
                }

                if let location = _response.location {
                    self.locatioStr = location.name
                }
                self.rocketModelStr = _response.rocket.name

                DispatchQueue.main.async {
                    self.view?.updateUI()
                }
                self.isLoading = false
            }
        }
    }


    var titleStr: String = ""
    var timeStr: String = ""

    var missionTitleStr: String?
    var missionSubTitleStr: String?
    var missionDetailStr: String?

    var rocketModelStr: String?
    var locatioStr: String?

    var streamStr: String?

    
}
