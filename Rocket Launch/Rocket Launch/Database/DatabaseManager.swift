//
//  DatabaseManager.swift
//  Rocket Launch
//
//  Created by Maxym Sahaydak on 2/15/18.
//  Copyright © 2018 Maxym Sahaydak. All rights reserved.
//

import Foundation
import CoreData

class DatabaseManager {
    static let shared: DatabaseManager = DatabaseManager()

    private init() { }

    func addToFavorite(_ baseLauchInfo: BaseInfoModel) {
        _likedIds = nil
        let launch = LaunchBaseDB(context: self.persistentContainer.viewContext)
        launch.fill(with: baseLauchInfo)
        self.saveContext()
    }

    func removeLauncModel(_ model: LaunchBaseDB) {
        _likedIds = nil
        persistentContainer.viewContext.delete(model)
        self.saveContext()
    }

    func updateFavorite(with baseLauchInfo: BaseInfoModel) {
        let fetchRequest = LaunchBaseDB.createFetchRequest()
        let predicate = NSPredicate(format: "id = %d", baseLauchInfo.id!)
        fetchRequest.predicate = predicate
        do {
            let results = try persistentContainer.viewContext.fetch(fetchRequest)
            if results.count > 0 {
                guard let model = results.first else {return}
                removeLauncModel(model)
            } else {
                self.addToFavorite(baseLauchInfo)
            }
        } catch {
            print("fetch error")
        }
    }

    func getAllLikedIds() -> [Int] {
        let fetchRequest = LaunchBaseDB.createFetchRequest()
        do {
            let results = try persistentContainer.viewContext.fetch(fetchRequest)
            let idsArr = results.map{Int($0.id)}
            return idsArr
        } catch {
            return [Int]()
        }
    }

    //MARK: - Tmp solution
    private var _likedIds:[Int]?
    var likedIds:[Int] {
        get {
            if _likedIds == nil {
                _likedIds = getAllLikedIds()
            }
            return _likedIds!
        }
    }


    // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "Rocket_Launch")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
