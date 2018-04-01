//
//  SearchFieldView.swift
//  Second
//
//  Created by Собко Евгений on 31.03.2018.
//  Copyright © 2018 Sobko Evgeniy. All rights reserved.
//

import UIKit

class SearchFieldView: UIView {

    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = Constants.textFieldPlaceholder
        return textField
    }()
    lazy var searchIcon: UIImageView = {
        let searchIcon = UIImageView()
        searchIcon.image = UIImage(imageLiteralResourceName: Constants.searchIconImageName)
        return searchIcon
    }()
    lazy var cameraIcon: UIImageView = {
        let cameraIcon = UIImageView()
        cameraIcon.image = UIImage(imageLiteralResourceName: Constants.cameraIconImageName)
        return cameraIcon
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    private func setup() {
        setupSubviews()
        setupConstraints()
    }
    
    private func setupSubviews() {
        addSubview(textField)
        addSubview(searchIcon)
        addSubview(cameraIcon)
    }
    
    private func setupConstraints() {
        textField.translatesAutoresizingMaskIntoConstraints = false
        searchIcon.translatesAutoresizingMaskIntoConstraints = false
        cameraIcon.translatesAutoresizingMaskIntoConstraints = false
        let margins = layoutMarginsGuide
        let constraints = [
            searchIcon.topAnchor.constraint(equalTo: margins.topAnchor),
            searchIcon.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            searchIcon.bottomAnchor.constraint(equalTo: margins.bottomAnchor),
            searchIcon.trailingAnchor.constraint(equalTo: textField.leadingAnchor,
                                                 constant: -Constants.spaceBetweenTextFieldsAndIcons),
            searchIcon.widthAnchor.constraint(equalTo: searchIcon.heightAnchor),
            textField.topAnchor.constraint(equalTo: margins.topAnchor),
            textField.bottomAnchor.constraint(equalTo: margins.bottomAnchor),
            textField.heightAnchor.constraint(equalToConstant: textField.intrinsicContentSize.height),
            cameraIcon.leadingAnchor.constraint(equalTo: textField.trailingAnchor,
                                                constant: Constants.spaceBetweenTextFieldsAndIcons),
            cameraIcon.topAnchor.constraint(equalTo: margins.topAnchor),
            cameraIcon.bottomAnchor.constraint(equalTo: margins.bottomAnchor),
            cameraIcon.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            cameraIcon.widthAnchor.constraint(equalTo: cameraIcon.heightAnchor),
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    enum Constants {
        static let textFieldPlaceholder = "Search"
        static let searchIconImageName = "search"
        static let cameraIconImageName = "camera"
        static let spaceBetweenTextFieldsAndIcons: CGFloat = 8
    }
    
}
