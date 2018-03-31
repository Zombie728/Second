//
//  SearchFieldView.swift
//  Second
//
//  Created by Собко Евгений on 31.03.2018.
//  Copyright © 2018 Sobko Evgeniy. All rights reserved.
//

import UIKit

class SearchFieldView: UIView {

    let textField = UITextField()
    let searchIcon = UIImageView()
    let cameraIcon = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupSubviews()
        setupConstraints()
    }
    
    private func setupSubviews() {
        addSubview(textField)
        addSubview(searchIcon)
        addSubview(cameraIcon)
        textField.placeholder = "Search"
        searchIcon.image = UIImage(imageLiteralResourceName: "search")
        cameraIcon.image = UIImage(imageLiteralResourceName: "camera")
    }
    
    private func setupConstraints() {
        textField.translatesAutoresizingMaskIntoConstraints = false
        searchIcon.translatesAutoresizingMaskIntoConstraints = false
        cameraIcon.translatesAutoresizingMaskIntoConstraints = false
        let margins = layoutMarginsGuide
        let constraints =
            [searchIcon.topAnchor.constraint(equalTo: margins.topAnchor),
             searchIcon.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
             searchIcon.bottomAnchor.constraint(equalTo: margins.bottomAnchor),
             searchIcon.trailingAnchor.constraint(equalTo: textField.leadingAnchor, constant: -8),
             searchIcon.widthAnchor.constraint(equalTo: searchIcon.heightAnchor),
             textField.topAnchor.constraint(equalTo: margins.topAnchor),
             textField.bottomAnchor.constraint(equalTo: margins.bottomAnchor),
             textField.heightAnchor.constraint(equalToConstant: textField.intrinsicContentSize.height),
             cameraIcon.leadingAnchor.constraint(equalTo: textField.trailingAnchor, constant: 8),
             cameraIcon.topAnchor.constraint(equalTo: margins.topAnchor),
             cameraIcon.bottomAnchor.constraint(equalTo: margins.bottomAnchor),
             cameraIcon.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
             cameraIcon.widthAnchor.constraint(equalTo: cameraIcon.heightAnchor)]
        NSLayoutConstraint.activate(constraints)
    }
    
}
