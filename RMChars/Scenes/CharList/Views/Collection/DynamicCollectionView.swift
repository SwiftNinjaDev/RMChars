//
//  DynamicCollectionView.swift
//  RMChars
//
//  Created by Nikolai Kharkevich on 02.05.2024.
//

import UIKit

public class DynamicCollectionView: UICollectionView {
    
    public override var intrinsicContentSize: CGSize {
        self.contentSize
    }

    public override var contentSize: CGSize {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }
}
