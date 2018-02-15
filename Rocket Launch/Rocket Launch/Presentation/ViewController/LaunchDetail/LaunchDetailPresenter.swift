//
//  LaunchDetailVCPresenter.swift
//  Rocket Launch
//
//  Created by Maxym Sahaydak on 2/14/18.
//  Copyright © 2018 Maxym Sahaydak. All rights reserved.
//

import Foundation
import UIKit

class LaunchDetailPresenter: BasePresenter {
    weak var view: LaunchDetailVC?
    //MARK: - Fetching methos
    func loadAlunchDetail(for launchId: Int) {
        self.isLoading = true
        BaseInfoAPIClient().getLaunchFullInfo(with: launchId) { (response, isSuccess, errorMessage) in
            if isSuccess {
                self.launchFullInfoModel = response
            } else {
                self.view?.showCustomAlert("Error", text: "Something went wrong, try agin later", handler: { _ in
                    self.view?.navigationController?.popViewController(animated: true)
                })            
            }
            self.isLoading = false
        }
    }

    var launchFullInfoModel: FullInfoModel? {
        didSet {
            guard let _launchFullInfoModel = launchFullInfoModel else {return}

            self.titleStr = _launchFullInfoModel.name ?? ""
            self.timeStr = _launchFullInfoModel.net ?? ""

            if let mission = _launchFullInfoModel.missions.first {
                self.missionDetailStr = mission.description
                self.missionTitleStr = mission.name
            }

            if let location = _launchFullInfoModel.location {
                self.locatioStr = location.name
                self.locationDetailsStr = location.pads.first?.name
            }

            self.rocketFamilNameStr = _launchFullInfoModel.rocket.familyname
            self.rocketModelStr = _launchFullInfoModel.rocket.name

            if let _streamUrl = _launchFullInfoModel.vidURL {
                self.streamURL = URL(string: /*_streamUrl*/"http://www.spacex.com/webcast/")
            }
            self.streamURL = URL(string: /*_streamUrl*/"http://www.spacex.com/webcast/")

            DispatchQueue.main.async {
                self.view?.updateUI()
            }
        }
    }

    func rocketDetailInfoBtnPressed() {
        if let _rocketWikiUrl = launchFullInfoModel?.rocket.wikiURL {
            let url = URL(string: _rocketWikiUrl)!
            isLoading = true
            UIApplication.shared.open(url, options: [:], completionHandler: { (isFinished) in
                self.isLoading = false
            })
        }
    }

    func locationBtnPressed() {
        if let _latitude = launchFullInfoModel?.location?.pads.first?.latitude, let _longitude = launchFullInfoModel?.location?.pads.first?.longitude {
            let url = URL(string: "http://maps.apple.com/maps?saddr=&daddr=\(_latitude),\(_longitude)")!
            isLoading = true
            UIApplication.shared.open(url, options: [:], completionHandler: { (isFinished) in
                self.isLoading = false
            })
        }
    }



    var titleStr: String = ""
    var timeStr: String = ""

    var missionTitleStr: String?
    var missionSubTitleStr: String?
    var missionDetailStr: String?

    var rocketFamilNameStr: String?
    var rocketModelStr: String?

    var locatioStr: String?
    var locationDetailsStr: String?

    var streamURL: URL?

    
}
