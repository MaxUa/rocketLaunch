//
//  LauncDetailInfoView.swift
//  Rocket Launch
//
//  Created by Maxym Sahaydak on 2/14/18.
//  Copyright © 2018 Maxym Sahaydak. All rights reserved.
//

import UIKit
import ReadMoreTextView

class LauncDetailInfoView: UIView {
    lazy var icoImageView: UIImageView = {
        var icoIV = UIImageView(frame: .zero)
        icoIV.contentMode = .center
        return icoIV
    }()

    lazy var titleLbl: UILabel = {
        var label = UILabel(frame: .zero)
        label.numberOfLines = 1
        label.font = UIFont.boldSystemFont(ofSize: 14.0)
        return label
    }()

    lazy var subTitleLbl: UILabel = {
        var subTitleLbl = UILabel(frame: .zero)
        subTitleLbl.numberOfLines = 0
        subTitleLbl.font = UIFont.italicSystemFont(ofSize: 12.0)
        return subTitleLbl
    }()

    lazy var textView: ReadMoreTextView = {
        var textView = ReadMoreTextView(frame: .zero)
        let readMoreTextAttributes: [NSAttributedStringKey: Any] = [
            NSAttributedStringKey.foregroundColor: UIColor.blue,
            NSAttributedStringKey.font: UIFont.systemFont(ofSize: 12)
        ]
        let readLessTextAttributes = [
            NSAttributedStringKey.foregroundColor: UIColor.red,
            NSAttributedStringKey.font: UIFont.systemFont(ofSize: 12)
        ]

        textView.attributedReadMoreText = NSAttributedString(string: "... Read more", attributes: readMoreTextAttributes)
        textView.attributedReadLessText = NSAttributedString(string: " Read less", attributes: readLessTextAttributes)

        textView.maximumNumberOfLines = 4
        textView.shouldTrim = true
        return textView
    }()


    //MAKR: - overridden methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("not implemented")
    }

    //MARK: -
    var icoSize: CGSize {
        get {
            return CGSize(width: 20.0, height: 20.0)
        }
    }

    var icoImage: UIImage? {
        didSet {
            icoImageView.image = icoImage
        }
    }

    //MAKR: -
    func commonInit() {
        self.backgroundColor = .white
        self.clipsToBounds = true
        mainContentLayout()
        additionalContetnLayout()
    }

    func mainContentLayout() {
        self.addSubview(icoImageView)
        self.addSubview(titleLbl)
        self.addSubview(subTitleLbl)

        self.icoImageView.translatesAutoresizingMaskIntoConstraints = false
        self.titleLbl.translatesAutoresizingMaskIntoConstraints = false
        self.subTitleLbl.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            icoImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8.0),
            icoImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8.0),
            icoImageView.widthAnchor.constraint(equalToConstant: icoSize.width),
            icoImageView.heightAnchor.constraint(equalToConstant: icoSize.height),

            titleLbl.leadingAnchor.constraint(equalTo: icoImageView.trailingAnchor, constant: 4.0),
            titleLbl.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 4.0),
            titleLbl.centerYAnchor.constraint(equalTo: icoImageView.centerYAnchor),

            subTitleLbl.topAnchor.constraint(greaterThanOrEqualTo: titleLbl.bottomAnchor),
            subTitleLbl.topAnchor.constraint(equalTo: icoImageView.bottomAnchor),
            subTitleLbl.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8.0),
            subTitleLbl.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 8.0)
            ])
    }

    func additionalContetnLayout() {
        self.addSubview(textView)

        self.textView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: self.subTitleLbl.bottomAnchor, constant: 8.0),
            textView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 4.0),
            textView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 4.0),
            textView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 4.0)
            ])
    }

    func layoutContetn() {
        self.icoImageView.translatesAutoresizingMaskIntoConstraints = false
        self.titleLbl.translatesAutoresizingMaskIntoConstraints = false
        self.subTitleLbl.translatesAutoresizingMaskIntoConstraints = false
        self.textView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            icoImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8.0),
            icoImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8.0),
            icoImageView.widthAnchor.constraint(equalToConstant: icoSize.width),
            icoImageView.heightAnchor.constraint(equalToConstant: icoSize.height),

            titleLbl.leadingAnchor.constraint(equalTo: icoImageView.trailingAnchor, constant: 4.0),
            titleLbl.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 4.0),
            titleLbl.centerYAnchor.constraint(equalTo: icoImageView.centerYAnchor),

            subTitleLbl.topAnchor.constraint(greaterThanOrEqualTo: titleLbl.bottomAnchor),
            subTitleLbl.topAnchor.constraint(equalTo: icoImageView.bottomAnchor),
            subTitleLbl.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8.0),
            subTitleLbl.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 8.0),

            textView.topAnchor.constraint(equalTo: self.subTitleLbl.bottomAnchor, constant: 8.0),
            textView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 4.0),
            textView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 4.0),
            textView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 4.0)

            ])
    }

}
