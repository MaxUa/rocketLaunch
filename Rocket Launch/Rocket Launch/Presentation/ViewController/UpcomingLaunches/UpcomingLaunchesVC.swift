//
//  UpcomingLaunchesViewController.swift
//  Rocket Launch
//
//  Created by Maxym Sahaydak on 2/12/18.
//  Copyright © 2018 Maxym Sahaydak. All rights reserved.
//

import UIKit
import CoreData

class UpcomingLaunchesVC: BaseVC {

    lazy var presenter: UpcomingLaunchesPresenter = {
        var presenter = UpcomingLaunchesPresenter()
        presenter.view = self
        return presenter
    }()

    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handlerefresh), for: .valueChanged)
        refreshControl.tintColor = UIColor.clear
        return refreshControl
    }()

    //MARK: - IBOutlet
    @IBOutlet weak var tableView: UITableView!


    //MARK: - Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initPresenter()
        presenter.loadUpcomingLaunches()

        tableView.addSubview(self.refreshControl)
        tableView.delegate = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
        tableView.tableFooterView = UIView(frame: .zero)

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        presenter.loadUpcomingLaunches()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: - Private methods
    override func initPresenter() {
        tableView.dataSource = presenter
        presenter.fetchedResultsController.delegate = self

        presenter.loadingStatusUpdated = {[weak self] in
            DispatchQueue.main.async {
                let isLoading = self?.presenter.isLoading ?? false
                if isLoading {
                    self?.showHUD()
                } else {
                    self?.hideHUD()
                    self?.refreshControl.endRefreshing()
                }
            }
        }

        presenter.reloadTableViewClosure = { [weak self] in
            self?.tableView.reloadData()
        }
        
        presenter.reloadCellClosure = {[weak self] (indexPath) in
            self?.tableView.reloadRows(at: [indexPath], with: .none)
        }

    }
    

    //MARK: - Actions
    @objc func handlerefresh() {
        presenter.loadUpcomingLaunches()
    }
}

extension UpcomingLaunchesVC {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as? LaunchDetailVC
        vc!.launchID = presenter.selectedLaunchId
    }
}

extension UpcomingLaunchesVC: NSFetchedResultsControllerDelegate {
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {

        case .delete:
            tableView.deleteRows(at: [indexPath!], with: .automatic)

        case .insert:
            tableView.insertRows(at: [newIndexPath!], with: .automatic)

        case .update:
            tableView.reloadRows(at: [indexPath!], with: .automatic)

        default:
            break
        }
    }
}

extension UpcomingLaunchesVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }

    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        presenter.didSelectCell(at: indexPath)
        return indexPath
    }
}
