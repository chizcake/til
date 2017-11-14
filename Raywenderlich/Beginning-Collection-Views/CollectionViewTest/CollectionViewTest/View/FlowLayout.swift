//
//  FlowLayout.swift
//  CollectionViewTest
//
//  Created by Henry on 09/11/2017.
//  Copyright © 2017 Henry. All rights reserved.
//

import UIKit

class FlowLayout: UICollectionViewFlowLayout {

    var addedItem: IndexPath?
    var removedItems: [IndexPath]?

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let attributes = super.layoutAttributesForElements(in: rect) else { return nil }
        var result = [UICollectionViewLayoutAttributes]()

        for item in attributes {
            guard let cellAttributes = item.copy() as? UICollectionViewLayoutAttributes else { return nil }
            if item.representedElementKind == nil {
                let frame = cellAttributes.frame
                cellAttributes.frame = frame.insetBy(dx: 2, dy: 2)
            }
            result.append(cellAttributes)
        }
        return result
    }

    override func initialLayoutAttributesForAppearingItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        guard let attributes = super.initialLayoutAttributesForAppearingItem(at: indexPath),
              let collectionView = collectionView,
              let added = addedItem,
              added == indexPath else { return nil }

        attributes.center = CGPoint(x: collectionView.frame.width - 23.5, y: -24.5)
        attributes.alpha = 1
        attributes.transform = CGAffineTransform(scaleX: 0.15, y: 0.15)
        attributes.zIndex = 5
        return attributes
    }

    override func finalLayoutAttributesForDisappearingItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        guard let attributes = super.finalLayoutAttributesForDisappearingItem(at: indexPath),
              let removed = removedItems,
              removed.contains(indexPath) else { return nil }

        attributes.alpha = 0
        attributes.transform = CGAffineTransform(scaleX: 0.15, y: 0.15)
        return attributes
    }
}
