//
//  WeakReference.swift
//

import Foundation

class WeakReference<T> where T: AnyObject {
    
    private(set) weak var value: T?
    
    init(value: T?) {
        self.value = value
    }
}

final class AnyWeakSubscriber<Handler> {
    let object: WeakReference<AnyObject>
    let handler: Handler
    
    init(object: AnyObject, handler: Handler) {
        self.object = WeakReference(value: object)
        self.handler = handler
    }
}
