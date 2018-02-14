//
//  RocketLaunchTVCell.swift
//  Rocket Launch
//
//  Created by Maxym Sahaydak on 2/12/18.
//  Copyright © 2018 Maxym Sahaydak. All rights reserved.
//

import UIKit

class RocketLaunchTVCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        self.textLabel?.numberOfLines = 0
        self.detailTextLabel?.numberOfLines = 0
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

    var launchInfo: BaseInfoModel? {
        didSet {
            if let _launchInfo = launchInfo {
                self.textLabel?.text = _launchInfo.name
                self.detailTextLabel?.text = _launchInfo.net
            }
        }
    }

}
