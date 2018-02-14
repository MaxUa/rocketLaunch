//
//  LaunchBaseInfoView.swift
//  Rocket Launch
//
//  Created by Maxym Sahaydak on 2/14/18.
//  Copyright © 2018 Maxym Sahaydak. All rights reserved.
//

import Foundation
import UIKit

class LaunchBaseInfoView: UIView {
    lazy var titleLbl: UILabel = {
        var titleLbl = UILabel(frame: .zero)
        titleLbl.font = UIFont.systemFont(ofSize: 14.0)
        titleLbl.numberOfLines = 0
        self.addSubview(titleLbl)
        return titleLbl
    }()

    lazy var dateLbl: UILabel = {
        var dateLbl = UILabel(frame: .zero)
        dateLbl.font = UIFont.systemFont(ofSize: 12.0)
        dateLbl.numberOfLines = 0
        self.addSubview(dateLbl)
        return dateLbl
    }()

    //MARK: - Life cycle methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        layoutContent()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("LaunchBaseInfoView init(coder) not implemented")
    }

    //MARK: - Public methods
    func update<T: LaunchInfoProtocol>(with model: T) {
        titleLbl.text = model.name
        dateLbl.text = model.net
    }

    //MARK: -
    func commonInit() {
        self.backgroundColor = .white
        layoutContent()
    }

    func layoutContent() {
        titleLbl.translatesAutoresizingMaskIntoConstraints = false
        dateLbl.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            titleLbl.topAnchor.constraint(equalTo: self.topAnchor, constant: 4.0),
            titleLbl.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 4.0),
            titleLbl.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 4.0),

            dateLbl.topAnchor.constraint(equalTo: titleLbl.bottomAnchor, constant: 4.0),
            dateLbl.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 4.0),
            dateLbl.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 4.0),
            dateLbl.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 4.0),
            ])
    }
}
