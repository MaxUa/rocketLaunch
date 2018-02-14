//
//  LaunchDetailVC.swift
//  Rocket Launch
//
//  Created by Maxym Sahaydak on 2/14/18.
//  Copyright © 2018 Maxym Sahaydak. All rights reserved.
//

import UIKit

class LaunchDetailVC: BaseVC {

    private lazy var presenter: LaunchDetailPresenter = {
        var presenter = LaunchDetailPresenter()
        return presenter
    }()

    var launchID: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        BaseInfoAPIClient().getLaunchFullInfo(with: 1290) { (response, isSuccess, errorMessage) in

        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
