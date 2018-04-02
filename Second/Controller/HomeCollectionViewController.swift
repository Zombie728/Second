//
//  HomeCollectionViewController.swift
//  Second
//
//  Created by Собко Евгений on 31.03.2018.
//  Copyright © 2018 Sobko Evgeniy. All rights reserved.
//

import UIKit

class HomeCollectionViewController: UICollectionViewController {
    
    override init(collectionViewLayout layout: UICollectionViewLayout) {
        super.init(collectionViewLayout: layout)
        setupTabBarItem()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupTabBarItem()
    }
    
    private func setupTabBarItem() {
        tabBarItem = UITabBarItem(title: Constants.tabBarItemTitle,
                                  image: UIImage(named: Constants.tabBarItemImageName), selectedImage: nil)
    }
    
    lazy var searchFieldView: SearchFieldView = {
        let searchFieldView = SearchFieldView()
        searchFieldView.translatesAutoresizingMaskIntoConstraints = false
        searchFieldView.backgroundColor = Constants.searchFieldViewBackgroundColor
        searchFieldView.layer.cornerRadius = Constants.searchFieldViewCornerRadius
        return searchFieldView
    }()
    lazy var layout = collectionViewLayout as? PictureCollectionViewLayout ?? PictureCollectionViewLayout()
    private var viewWidth: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView?.register(PictureCollectionViewCell.self,
                                      forCellWithReuseIdentifier: Constants.cellReuseIdentifier)
        layout.delegate = self
        setupBackgroundColors()
        setupSubviews()
        collectionView?.translatesAutoresizingMaskIntoConstraints = false
        setupConstraints()
    }
    
    private func setupBackgroundColors() {
        view.backgroundColor = Constants.viewBackgroundColor
        collectionView?.backgroundColor = Constants.viewBackgroundColor
    }
    
    private func setupSubviews() {
        view.addSubview(searchFieldView)
    }
    
    private func setupConstraints() {
        if let (cv, tb) = (collectionView, tabBarController?.tabBar) as? (UICollectionView, UITabBar) {
            let margins = view.layoutMarginsGuide
            let constraints = [
                searchFieldView.topAnchor.constraint(equalTo: margins.topAnchor),
                searchFieldView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
                searchFieldView.bottomAnchor
                    .constraint(equalTo: cv.topAnchor,
                                constant: -Constants.spaceBetweenSearchFieldViewAndCollectionView),
                searchFieldView.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
                cv.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
                cv.bottomAnchor.constraint(equalTo: margins.bottomAnchor,
                                           constant: tb.bounds.height),
                cv.trailingAnchor.constraint(equalTo: margins.trailingAnchor)
            ]
            NSLayoutConstraint.activate(constraints)
        }
    }

    override func viewDidLayoutSubviews() {
        if viewWidth != view.bounds.width {
            layout.prepare(forAnimatedBoundsChange: .zero)
            viewWidth = view.bounds.width
        }
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Picture.all.count
    }

    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PictureCollectionViewCell", for: indexPath)
        if let pictureCell = cell as? PictureCollectionViewCell {
            pictureCell.imageView.image = UIImage(named: Picture.all[indexPath.item].imageName)
        }
        return cell
    }

    enum Constants {
        static let tabBarItemTitle = "Home"
        static let tabBarItemImageName = "Home"
        static let cellReuseIdentifier = "PictureCollectionViewCell"
        static let viewBackgroundColor = UIColor.white
        static let searchFieldViewBackgroundColor = #colorLiteral(red: 0.9371530414, green: 0.9373135567, blue: 0.9371429086, alpha: 1)
        static let searchFieldViewCornerRadius: CGFloat = 8
        static let spaceBetweenSearchFieldViewAndCollectionView: CGFloat = 8
    }
    
}

extension HomeCollectionViewController: PictureCollectionViewLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
        var cellWidth: CGFloat = 0
        if let collectionViewWidth = self.collectionView?.bounds.width {
            cellWidth = collectionViewWidth / CGFloat(layout.numberOfColumns)
                - 2 * PictureCollectionViewLayout.Constants.cellPadding
        }
        let image = UIImage(named: Picture.all[indexPath.item].imageName) ?? UIImage()
        let ratio = image.size.height / image.size.width
        return cellWidth * ratio + PictureCollectionViewCell.Constants.buttonHeight
    }
}
