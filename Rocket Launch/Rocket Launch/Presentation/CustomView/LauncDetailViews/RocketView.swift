//
//  RocketView.swift
//  Rocket Launch
//
//  Created by Maxym Sahaydak on 2/14/18.
//  Copyright © 2018 Maxym Sahaydak. All rights reserved.
//
 import UIKit

class RocketView: LauncDetailInfoView {
    lazy var button: UIButton = {
        var button = UIButton(type: .custom)
        return button
    }()

    var buttonIco: UIImage? {
        didSet {
            button.setImage(buttonIco, for: .normal)
        }
    }

    var btnPressedClosure: (()->Void)?

    override func additionalContetnLayout() {
        self.addSubview(textView)
        self.addSubview(button)
        textView.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            button.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8.0),
            button.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            button.widthAnchor.constraint(equalToConstant: 40.0),
            button.heightAnchor.constraint(equalToConstant: 40.0),

            textView.topAnchor.constraint(equalTo: self.subTitleLbl.bottomAnchor, constant: 8.0),
            textView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8.0),
            textView.trailingAnchor.constraint(equalTo: button.leadingAnchor, constant: 8.0),
            textView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 4.0),
            ])
    }
}
