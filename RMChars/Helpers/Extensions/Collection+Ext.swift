//
//  Collection+Ext.swift
//  RMChars
//
//  Created by Nikolai Kharkevich on 02.05.2024.
//

import Foundation

public extension Collection {
    /// Returns the element at the specified index if it is within bounds, otherwise nil.
    subscript(safe index: Index) -> Element? {
        guard indices.contains(index) else {
            return nil
        }
        
        return self[index]
    }
}
