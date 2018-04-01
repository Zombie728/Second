//
//  PictureCollectionViewLayout.swift
//  Second
//
//  Created by Собко Евгений on 31.03.2018.
//  Copyright © 2018 Sobko Evgeniy. All rights reserved.
//

import UIKit

class PictureCollectionViewLayout: UICollectionViewLayout {

    weak var delegate: HomeCollectionViewController?
    var space: CGFloat = 8
    var numberOfColumns = 0//UIDevice.current.userInterfaceIdiom == .pad ? 4 : 2
    
    private var allAttributes = [UICollectionViewLayoutAttributes]()

    lazy override var collectionViewContentSize: CGSize = .zero
    
    override func prepare() {
        allAttributes = []
        numberOfColumns = delegate!.traitCollection.horizontalSizeClass == .compact ? 2 : 3
        let width = ((collectionView!.bounds.width) - space * CGFloat(numberOfColumns - 1)) / CGFloat(numberOfColumns) // Ширина одного столбца
        let horizontalCoordinatesOfColumns: [CGFloat] = (0..<numberOfColumns).map { CGFloat($0) * (width + space) } // Горизонтальные координаты левых границ столбцов
        var verticalCoordinatesInColumns = [CGFloat](repeating: 0, count: numberOfColumns) // Вертикальные координаты нижних границ столбцов (+ отступ)
        for index in 0..<collectionView!.numberOfItems(inSection: 0) {
            let indexPath = IndexPath(item: index, section: 0)
            let size = CGSize(width: width, height: delegate!.heightForItemAtIndexPath(indexPath)) // Размер ячейки
            let sortedVerticalCoordinatesInColumns = verticalCoordinatesInColumns.enumerated().sorted {
                if $0.element < $1.element { return true } // Сортировка столбцов по возрастанию их высоты, то есть нахождение самого короткого
                else if $0.element > $1.element { return false }
                else { return $0.offset < $1.offset } // Если два столбца имеют одинаковую высоту, то выбирается левый
            }
            let lowestColumnIndex = sortedVerticalCoordinatesInColumns.first!.offset // Выбор самого короткого столбца
            let origin = CGPoint(x: horizontalCoordinatesOfColumns[lowestColumnIndex], y: verticalCoordinatesInColumns[lowestColumnIndex]) // Координаты ячейки, добавляемой в самый короткий столбец
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = CGRect(origin: origin, size: size)
            allAttributes.append(attributes)
            verticalCoordinatesInColumns[lowestColumnIndex] += size.height + space // Изменение высоты столбца, то есть сдвиг его нижней границы
        }
        collectionViewContentSize.width = collectionView!.bounds.width
        collectionViewContentSize.height = verticalCoordinatesInColumns.max()!
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
       return allAttributes
    }
    
}
