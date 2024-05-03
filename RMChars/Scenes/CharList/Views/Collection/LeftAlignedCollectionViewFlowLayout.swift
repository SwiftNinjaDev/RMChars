//
//  LeftAlignedCollectionViewFlowLayout.swift
//  RMChars
//
//  Created by Nikolai Kharkevich on 02.05.2024.
//

import UIKit

public class LeftAlignedCollectionViewFlowLayout: UICollectionViewFlowLayout {

    public required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    public required init(minimumLineSpacing: CGFloat, minimumInteritemSpacing: CGFloat) {
        super.init()

        self.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        self.minimumLineSpacing = minimumLineSpacing
        self.minimumInteritemSpacing = minimumInteritemSpacing
    }

    public override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {

        guard let attributes = super.layoutAttributesForElements(in: rect) else { return [] }

        var x: CGFloat = sectionInset.left
        var y: CGFloat = -1.0

        for attribute in attributes {
            if attribute.representedElementCategory != .cell { continue }

            if attribute.frame.origin.y >= y {
                x = sectionInset.left
            }

            attribute.frame.origin.x = x

            x += attribute.frame.width + self.minimumInteritemSpacing
            y = attribute.frame.maxY
        }

        return attributes
    }
}
