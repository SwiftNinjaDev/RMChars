//
//  StateSubscription.swift
//

import Foundation

public protocol Subscription {
    func stop()
}

public class GenericStateSubscription<State>: Subscription {
    
    private(set) var block: ((State) -> Void)?

    init(_ block: @escaping (State) -> Void) {
        self.block = block
    }

    public func fire(_ state: State) {
        block?(state)
    }

    public func stop() {
        block = nil
    }

    deinit {
        stop()
    }
}
