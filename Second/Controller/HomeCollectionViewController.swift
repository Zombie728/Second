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
        tabBarItem = UITabBarItem(title: "Home", image: UIImage(imageLiteralResourceName: "Home"), selectedImage: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        tabBarItem = UITabBarItem(title: "Home", image: UIImage(imageLiteralResourceName: "Home"), selectedImage: nil)
    }
    
    let searchFieldView = SearchFieldView()
    lazy var layout = collectionViewLayout as! PictureCollectionViewLayout
    private var viewWidth: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView!.register(PictureCollectionViewCell.self, forCellWithReuseIdentifier: "PictureCollectionViewCell")
        layout.delegate = self
        setupSubviews()
        setupConstraints()
    }
    
    private func setupSubviews() {
        view.addSubview(searchFieldView)
        view.backgroundColor = .white
        collectionView!.backgroundColor = .white
        searchFieldView.backgroundColor = #colorLiteral(red: 0.9371530414, green: 0.9373135567, blue: 0.9371429086, alpha: 1)
    }
    
    private func setupConstraints() {
        collectionView!.translatesAutoresizingMaskIntoConstraints = false
        searchFieldView.translatesAutoresizingMaskIntoConstraints = false
        let margins = view.layoutMarginsGuide
        let constraints =
            [searchFieldView.topAnchor.constraint(equalTo: margins.topAnchor),
             searchFieldView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
             searchFieldView.bottomAnchor.constraint(equalTo: collectionView!.topAnchor, constant: -8),
             searchFieldView.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
             collectionView!.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
             collectionView!.bottomAnchor.constraint(equalTo: margins.bottomAnchor, constant: tabBarController!.tabBar.bounds.height),
             collectionView!.trailingAnchor.constraint(equalTo: margins.trailingAnchor)]
        NSLayoutConstraint.activate(constraints)
    }

    override func viewDidLayoutSubviews() {
        searchFieldView.layer.cornerRadius = searchFieldView.bounds.height / 5
        for cell in collectionView?.visibleCells as! [PictureCollectionViewCell] {
            cell.calculateCornerRadius()
        }
        if viewWidth != view.bounds.width {
            layout.invalidateLayout()
            viewWidth = view.bounds.width
        }
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Picture.all.count
    }
    
    func heightForItemAtIndexPath(_ indexPath: IndexPath) -> CGFloat {
        let width = ((collectionView?.bounds.width)! - layout.space * CGFloat(layout.numberOfColumns - 1)) / CGFloat(layout.numberOfColumns)
        let image = UIImage(imageLiteralResourceName: Picture.all[indexPath.item].imageName)
        let ratio = image.size.height / image.size.width
        return width * ratio + PictureCollectionViewCell.buttonHeight
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PictureCollectionViewCell", for: indexPath) as! PictureCollectionViewCell
        cell.imageView.image = UIImage(imageLiteralResourceName: Picture.all[indexPath.item].imageName)
        return cell
    }

}
