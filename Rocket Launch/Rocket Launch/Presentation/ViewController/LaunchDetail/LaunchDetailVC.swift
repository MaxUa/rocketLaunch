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
//        presenter.loadAlunchDetail(for: launchID!)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
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
        missionInfoView.titleLbl.text = "Mission"
        missionInfoView.icoImage = UIImage(named: "info_ico")
        return missionInfoView
    }()

    lazy var rocketInfoView: RocketView = {
        var rocketInfoView = RocketView()
        rocketInfoView.titleLbl.text = "Rocket"
        rocketInfoView.icoImage = UIImage(named: "rocket_ico")
        rocketInfoView.buttonIco = UIImage(named: "info_btn_ico")
        rocketInfoView.btnPressedClosure = { [weak self] in
            self?.presenter.rocketDetailInfoBtnPressed()
        }
        return rocketInfoView
    }()

    lazy var locationView: RocketView = {
        var locationView = RocketView(frame: .zero)
        locationView.titleLbl.text = "Location"
        locationView.icoImage = UIImage(named: "location_ico")
        locationView.buttonIco = UIImage(named: "location_btn_ico")
        locationView.btnPressedClosure = {[weak self] in
            self?.presenter.locationBtnPressed()
        }
        return locationView
    }()

    lazy var streamView: LauncDetailInfoView = {
        var streamView = LauncDetailInfoView(frame: .zero)
        streamView.icoImage = UIImage(named: "stream_ico")
        return streamView
    }()

    //MARK: -
    func updateUI() {
        baseInfoView.titleLbl.text = presenter.titleStr
        baseInfoView.dateLbl.text = presenter.timeStr
        stackView.addArrangedSubview(baseInfoView)

        if let _missionDetailStr = presenter.missionDetailStr {
            missionInfoView.textView.text = _missionDetailStr
            missionInfoView.subTitleLbl.text = presenter.missionSubTitleStr

            stackView.addArrangedSubview(missionInfoView)
        }

        if let _rocketModel = presenter.rocketModelStr {
            rocketInfoView.subTitleLbl.text = presenter.rocketFamilNameStr
            rocketInfoView.textView.text = _rocketModel

            stackView.addArrangedSubview(rocketInfoView)
        }


        locationView.subTitleLbl.text = presenter.locatioStr
        locationView.textView.text = presenter.locationDetailsStr
        stackView.addArrangedSubview(locationView)

        if let _streamUrl = presenter.streamURL {
            streamView.titleLbl.text = "Stream"
            streamView.textView.text = _streamUrl.absoluteString
            stackView.addArrangedSubview(streamView)
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
