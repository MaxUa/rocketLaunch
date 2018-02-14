//
//  BaseVC.swift
//  Rocket Launch
//
//  Created by Maxym Sahaydak on 2/12/18.
//  Copyright © 2018 Maxym Sahaydak. All rights reserved.
//

import UIKit
import SwiftProgressHUD

class BaseVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MAKR: - Base methods
    func showHUD() {
        SwiftProgressHUD.showWait()
    }

    func hideHUD() {
        SwiftProgressHUD.hideAllHUD()
    }

    func initPresenter() {
        fatalError("Presenter should be created for inherited class")
    }
}
