//
//  PictureCollectionViewLayout.swift
//  Second
//
//  Created by Собко Евгений on 31.03.2018.
//  Copyright © 2018 Sobko Evgeniy. All rights reserved.
//

import UIKit

protocol PictureCollectionViewLayoutDelegate: class {
    var traitCollection: UITraitCollection { get }
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat
}

class PictureCollectionViewLayout: UICollectionViewLayout {

    weak var delegate: PictureCollectionViewLayoutDelegate?
    var numberOfColumns = 0
    private var cache: [UICollectionViewLayoutAttributes] = []
    private var contentHeight: CGFloat = 0
    
    private var contentWidth: CGFloat {
        guard let collectionView = collectionView else {
            return 0
        }
        let insets = collectionView.contentInset
        return collectionView.bounds.width - (insets.left + insets.right)
    }
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    override func prepare() {
        guard cache.isEmpty == true, let collectionView = collectionView else {
            return
        }
        numberOfColumns = delegate?.traitCollection.horizontalSizeClass == .regular ?
            Constants.numberOfColumnsForRegularWidth : Constants.numberOfColumnsForCompactWidth
        let columnWidth = (contentWidth + Constants.cellPadding * 2) / CGFloat(numberOfColumns)
        var xOffset: [CGFloat] = []
        for column in 0 ..< numberOfColumns {
            xOffset.append(CGFloat(column) * columnWidth - Constants.cellPadding)
        }
        var column = 0
        var yOffset = [CGFloat](repeating: 0, count: numberOfColumns)
        for item in 0 ..< collectionView.numberOfItems(inSection: 0) {
            let indexPath = IndexPath(item: item, section: 0)
            let photoHeight = delegate?.collectionView(collectionView, heightForPhotoAtIndexPath: indexPath) ?? 0
            let height = Constants.cellPadding * 2 + photoHeight
            let frame = CGRect(x: xOffset[column], y: yOffset[column], width: columnWidth, height: height)
            let insetFrame = frame.insetBy(dx: Constants.cellPadding, dy: Constants.cellPadding)
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = insetFrame
            cache.append(attributes)
            contentHeight = max(contentHeight, frame.maxY)
            yOffset[column] = yOffset[column] + height
            column = yOffset.indexOfMinimum()
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var visibleLayoutAttributes: [UICollectionViewLayoutAttributes] = []
        for attributes in cache where attributes.frame.intersects(rect) {
            visibleLayoutAttributes.append(attributes)
        }
        return visibleLayoutAttributes
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cache[indexPath.item]
    }
    
    override func prepare(forAnimatedBoundsChange oldBounds: CGRect) {
        cache = []
        contentHeight = 0
        invalidateLayout()
    }
    
    enum Constants {
        static let cellPadding: CGFloat = 8
        static let numberOfColumnsForRegularWidth = 4
        static let numberOfColumnsForCompactWidth = 2
    }
    
}

extension Array where Element : Comparable {
    func indexOfMinimum() -> Int {
        var indexOfMinimum = 0
        for (index, element) in self.enumerated() where element < self[indexOfMinimum] {
            indexOfMinimum = index
        }
        return indexOfMinimum
    }
}
