//
//  UpcomingLaunchesPresenter.swift
//  Rocket Launch
//
//  Created by Maxym Sahaydak on 2/13/18.
//  Copyright © 2018 Maxym Sahaydak. All rights reserved.
//

import Foundation
import UIKit

class UpcomingLaunchesPresenter: BasePresenter {

    //MARK: - Closure
    var reloadTableViewClosure: (()->())?

    //MAKR: - Private variables
    private var upcomingLaunchesArr: [BaseInfoModel] = [BaseInfoModel]() {
        didSet {
            reloadTableViewClosure?()
        }
    }

    //MARK: - Read only
    private(set) var selectedLaunchId: Int?
    
    func loadUpcomingLaunches() {
        self.isLoading = true
        BaseInfoAPIClient().getUpcomingLaunches { [weak self] (responseArr, isSuccess, errorMessage) in
            self?.isLoading = false
            if let launchesInfoArr = responseArr {
                self?.upcomingLaunchesArr = launchesInfoArr
            }
        }
    }

    func didSelectCell(at indexPath: IndexPath) {
        selectedLaunchId = upcomingLaunchesArr[indexPath.row].id
    }
}


extension UpcomingLaunchesPresenter: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return upcomingLaunchesArr.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LaunchCellID") as! RocketLaunchTVCell
        cell.launchInfo = upcomingLaunchesArr[indexPath.row]
        return cell
    }
}
