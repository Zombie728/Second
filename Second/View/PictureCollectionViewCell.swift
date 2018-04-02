//
//  PictureCollectionViewCell.swift
//  Second
//
//  Created by Собко Евгений on 31.03.2018.
//  Copyright © 2018 Sobko Evgeniy. All rights reserved.
//

import UIKit

class PictureCollectionViewCell: UICollectionViewCell {
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = Constants.imageViewCornerRadius
        return imageView
    }()
    lazy var buttonOfActions: UIButton = {
        let buttonOfActions = UIButton()
        buttonOfActions.translatesAutoresizingMaskIntoConstraints = false
        buttonOfActions.titleLabel?.font = UIFont.systemFont(ofSize: Constants.buttonFontSize)
        buttonOfActions.setTitle(Constants.buttonTitle, for: .normal)
        buttonOfActions.setTitleColor(Constants.buttonTitleColor, for: .normal)
        return buttonOfActions
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
        addSubview(imageView)
        addSubview(buttonOfActions)
    }
    
    private func setupConstraints() {
        let constraints = [
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            buttonOfActions.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            buttonOfActions.bottomAnchor.constraint(equalTo: bottomAnchor),
            buttonOfActions.trailingAnchor.constraint(equalTo: trailingAnchor),
            buttonOfActions.heightAnchor.constraint(equalToConstant: Constants.buttonHeight),
        ]
        NSLayoutConstraint.activate(constraints)
    }

    enum Constants {
        static let imageViewCornerRadius: CGFloat = 8
        static let buttonFontSize: CGFloat = 5
        static let buttonTitle = "●●●"
        static let buttonTitleColor = #colorLiteral(red: 0.4901400805, green: 0.4902282953, blue: 0.4901344776, alpha: 1)
        static let buttonHeight: CGFloat = 18
    }
    
}
