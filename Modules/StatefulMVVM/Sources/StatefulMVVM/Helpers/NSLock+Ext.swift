//
//  NSLock+Ext.swift
//

import Foundation

extension NSLock {
    
    @discardableResult
    func sync<T>(block: () -> T) -> T {
        lock()
        let result = block()
        unlock()
        return result
    }
}
