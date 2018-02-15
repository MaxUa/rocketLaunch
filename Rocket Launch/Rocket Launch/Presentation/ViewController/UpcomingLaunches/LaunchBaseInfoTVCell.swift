//
//  RocketLaunchTVCell.swift
//  Rocket Launch
//
//  Created by Maxym Sahaydak on 2/12/18.
//  Copyright © 2018 Maxym Sahaydak. All rights reserved.
//

import UIKit
protocol RocketLaunchTVCellProtocol: class {
    func didTapLikeBtn(for id: Int?, isLiked: Bool)
}
class RocketLaunchTVCell: UITableViewCell {

    weak var delegate: RocketLaunchTVCellProtocol?
    var launchId: Int?
    var isLiked: Bool = false {
        didSet {
            likeBtn.isSelected = isLiked
        }
    }


    override func awakeFromNib() {
        super.awakeFromNib()

        // Initialization code
    }

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var subTitleLbl: UILabel!
    @IBOutlet weak var likeBtn: UIButton!

    @IBAction func likeBtnPressed(_ sender: UIButton) {
        let isLiked = !self.isLiked
        self.isLiked = isLiked
        delegate?.didTapLikeBtn(for: launchId, isLiked: isLiked)
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

    var launchInfo: BaseInfoModel? {
        didSet {
            if let _launchInfo = launchInfo {
                self.launchId = _launchInfo.id
                self.titleLbl?.text = _launchInfo.name
                self.subTitleLbl?.text = _launchInfo.net
                self.isLiked = _launchInfo.isLiked
            }
        }
    }

    

}
