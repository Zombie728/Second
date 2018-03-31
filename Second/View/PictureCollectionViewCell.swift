//
//  PictureCollectionViewCell.swift
//  Second
//
//  Created by Собко Евгений on 31.03.2018.
//  Copyright © 2018 Sobko Evgeniy. All rights reserved.
//

import UIKit

class PictureCollectionViewCell: UICollectionViewCell {
    let imageView = UIImageView()
    let buttonWithManyPoints = UIButton()

    static let buttonHeight: CGFloat = {
        let button = UIButton()
        button.titleLabel?.font = UIFont.systemFont(ofSize: 5)
        return button.intrinsicContentSize.height
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
        setupConstrains()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupSubviews()
        setupConstrains()
    }

    private func setupSubviews() {
        addSubview(imageView)
        addSubview(buttonWithManyPoints)
        
        imageView.clipsToBounds = true
        buttonWithManyPoints.titleLabel?.font = UIFont.systemFont(ofSize: 5)
        buttonWithManyPoints.setTitle("●●●", for: .normal)
        buttonWithManyPoints.setTitleColor(#colorLiteral(red: 0.4901400805, green: 0.4902282953, blue: 0.4901344776, alpha: 1), for: .normal)
    }
    
    private func setupConstrains() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        buttonWithManyPoints.translatesAutoresizingMaskIntoConstraints = false
        let constraints =
            [imageView.topAnchor.constraint(equalTo: topAnchor),
             imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
             imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
             buttonWithManyPoints.topAnchor.constraint(equalTo: imageView.bottomAnchor),
             buttonWithManyPoints.bottomAnchor.constraint(equalTo: bottomAnchor),
             buttonWithManyPoints.trailingAnchor.constraint(equalTo: trailingAnchor)]
        NSLayoutConstraint.activate(constraints)
    }

    func calculateCornerRadius() {
        imageView.layer.cornerRadius = bounds.width / 20
    }

}
