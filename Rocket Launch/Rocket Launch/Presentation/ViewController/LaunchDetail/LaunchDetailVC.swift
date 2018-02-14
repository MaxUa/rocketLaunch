//
//  LaunchDetailVC.swift
//  Rocket Launch
//
//  Created by Maxym Sahaydak on 2/14/18.
//  Copyright © 2018 Maxym Sahaydak. All rights reserved.
//

import UIKit

class LaunchDetailVC: BaseVC {
    private(set) lazy var presenter: LaunchDetailPresenter = {
        var presenter = LaunchDetailPresenter()
        presenter.view = self
        return presenter
    }()

    var launchID: Int?

    //MARK: - IBOutlet
    @IBOutlet weak var stackView: UIStackView!


    //MARK: - Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        initPresenter()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.loadAlunchDetail(for: launchID!)
    }

    //MAKR: - Private subviews
    lazy var baseInfoView: LaunchBaseInfoView = {
        var baseInfoView = LaunchBaseInfoView(frame: .zero)
        rocketInfoView.icoImage = UIImage(named: "rocket_ico")
        return baseInfoView
    }()

    lazy var missionInfoView: LauncDetailInfoView = {
        var missionInfoView = LauncDetailInfoView(frame: .zero)
        missionInfoView.icoImage = UIImage(named: "info_ico")
        return missionInfoView
    }()

    lazy var rocketInfoView: RocketView = {
        var rocketInfoView = RocketView()
        rocketInfoView.icoImage = UIImage(named: "rocket_ico")
        rocketInfoView.buttonIco = UIImage(named: "info_btn_ico")
        rocketInfoView.btnPressedClosure = { [weak self] in

        }
        return rocketInfoView
    }()

    lazy var locationView: RocketView = {
        var locationView = RocketView(frame: .zero)
        locationView.icoImage = UIImage(named: "location_ico")
        locationView.buttonIco = UIImage(named: "location_btn_ico")
        locationView.btnPressedClosure = {[weak self] in

        }
        return locationView
    }()

    //MARK: -
    func updateUI() {
        baseInfoView.titleLbl.text = presenter.titleStr
        baseInfoView.dateLbl.text = presenter.timeStr
        stackView.addArrangedSubview(baseInfoView)

        if let _missionDetailStr = presenter.missionDetailStr {
            missionInfoView.titleLbl.text = "Mission"
            missionInfoView.textView.text = _missionDetailStr
            missionInfoView.subTitleLbl.text = presenter.missionSubTitleStr

            stackView.addArrangedSubview(missionInfoView)
        }

        if let _rocketModel = presenter.rocketModelStr {
            rocketInfoView.titleLbl.text = "Rocket"
            rocketInfoView.textView.text = _rocketModel

            stackView.addArrangedSubview(rocketInfoView)
        }

        if let _location = presenter.locatioStr {
            locationView.titleLbl.text = "Location"
            locationView.textView.text = _location
            
            stackView.addArrangedSubview(locationView)
        }
    }

    //MARK: -
    override func initPresenter() {
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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
