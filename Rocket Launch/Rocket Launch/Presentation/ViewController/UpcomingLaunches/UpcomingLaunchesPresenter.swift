//
//  UpcomingLaunchesPresenter.swift
//  Rocket Launch
//
//  Created by Maxym Sahaydak on 2/13/18.
//  Copyright © 2018 Maxym Sahaydak. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class UpcomingLaunchesPresenter: BasePresenter {

    weak var view: UpcomingLaunchesVC?
    var shouldReloadTV = false
    //MARK: - Closure
    var reloadTableViewClosure: (()->())?
    var reloadCellClosure: ((IndexPath)->Void)?

    //MARK: - FetchedResultsController
    var fetchedResultsController: NSFetchedResultsController<LaunchBaseDB>!

    //MARK: -
    override init() {
        if fetchedResultsController == nil {
            let request = LaunchBaseDB.createFetchRequest()
            let sort = NSSortDescriptor(key: "name", ascending: false)
            request.sortDescriptors = [sort]
            request.fetchBatchSize = 20

            fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: DatabaseManager.shared.persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        }

        do {
            try fetchedResultsController.performFetch()
        } catch {
            print("Fetch failed")
        }
    }

    //MARK: - Private methods
    private func launcInfoModel(with id: Int?) -> BaseInfoModel? {
        guard let _id = id else {return nil}
         return upcomingLaunchesArr.first { (model) -> Bool in
            return model.id == _id
        }
    }

    private func itemIndex(for itemId: Int) -> Int? {
        let index = self.upcomingLaunchesArr.index { (model) -> Bool in
            return model.id == itemId
        }
        return index
    }
    //MARK: - Private variables
    private var upcomingLaunchesArr: [BaseInfoModel] = [BaseInfoModel]() {
        didSet {
            if shouldReloadTV  {
                shouldReloadTV = false
                reloadTableViewClosure?()
            }
        }
    }
    
    

    private(set) var selectedLaunchId: Int?
    
    func loadUpcomingLaunches() {
        self.isLoading = true
        shouldReloadTV = true
        BaseInfoAPIClient().getUpcomingLaunches { [weak self] (responseArr, isSuccess, errorMessage) in
            self?.isLoading = false
            if isSuccess {
                if let launchesInfoArr = responseArr {
                    self?.upcomingLaunchesArr = launchesInfoArr.map({ (model) -> BaseInfoModel in
                        if DatabaseManager.shared.likedIds.contains(model.id!) {
                            var modified = model
                            modified.isLiked = true
                            return modified
                        }
                        return model
                    })
                }
            } else {
                self?.view?.showCustomAlert("Error", text: errorMessage ?? "Something went wrong, try agin later")
            }

        }
    }

    func didSelectCell(at indexPath: IndexPath) {
        let baseInfoModel = upcomingLaunchesArr[indexPath.row]
        selectedLaunchId = baseInfoModel.id
    }

    //MARK: - Private fucn
    fileprivate func checkIsLaunchLiked(for launchId: Int) -> Bool {
        return DatabaseManager.shared.likedIds.contains(launchId)
    }
}


extension UpcomingLaunchesPresenter: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return (section == 0) ?"Favorites" :"Upcoming"
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var numberOfRows = 0

        if section == 0 {
            let sectionInfo = fetchedResultsController.sections![section]
            numberOfRows = sectionInfo.numberOfObjects
        } else {
            numberOfRows = upcomingLaunchesArr.count
        }
        return numberOfRows
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LaunchCellID") as! RocketLaunchTVCell
        cell.delegate = self
        if indexPath.section == 1 {
            let launcInfoModel = upcomingLaunchesArr[indexPath.row]
            cell.launchInfo = launcInfoModel
        } else {
            cell.launchInfo = BaseInfoModel(with: fetchedResultsController.object(at: indexPath))
            cell.isLiked = true
        }
        return cell
    }
}

extension UpcomingLaunchesPresenter: RocketLaunchTVCellProtocol {
    func didTapLikeBtn(for id: Int?, isLiked: Bool) {
        if let selectedLaunchMode = launcInfoModel(with: id) {
            self.upcomingLaunchesArr = self.upcomingLaunchesArr.map({ (model) -> BaseInfoModel in
                if id == model.id {
                    var newModel = model
                    newModel.isLiked = isLiked
                    return newModel
                }
                return model
            })
            if let reloadIndex = self.itemIndex(for: id!) {
                reloadCellClosure?(IndexPath(row: reloadIndex, section: 1))
            }
            
            DatabaseManager.shared.updateFavorite(with: selectedLaunchMode)
        }
    }
}
