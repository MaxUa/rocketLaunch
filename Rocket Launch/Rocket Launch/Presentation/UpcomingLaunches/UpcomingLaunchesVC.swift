//
//  UpcomingLaunchesViewController.swift
//  Rocket Launch
//
//  Created by Maxym Sahaydak on 2/12/18.
//  Copyright © 2018 Maxym Sahaydak. All rights reserved.
//

import UIKit

class UpcomingLaunchesVC: BaseVC {

    lazy var presenter: UpcomingLaunchesPresenter = {
        var presenter = UpcomingLaunchesPresenter()
        return presenter
    }()

    //MARK: - IBOutlet
    @IBOutlet weak var tableView: UITableView!


    //MARK: - Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initPresenter()

        tableView.delegate = self

        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
        tableView.tableFooterView = UIView(frame: .zero)

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.loadUpcomingLaunches()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: - Private methods
    func initPresenter() {
        tableView.dataSource = presenter

        presenter.loadingStatusUpdated = {[weak self] in
            DispatchQueue.main.async {
                let isLoading = self?.presenter.isLoading ?? false
                if isLoading {
                    self?.showHUD()
                } else {
                    self?.hideHUD()
                }
            }
        }

        presenter.reloadTableViewClosure = { [weak self] in
            self?.tableView.reloadData()
        }
    }
}

extension UpcomingLaunchesVC {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as? LaunchDetailVC
        vc!.launchID = presenter.selectedLaunchId
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
