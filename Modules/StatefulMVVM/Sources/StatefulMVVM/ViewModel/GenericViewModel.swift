//
//  ViewModel.swift
//  MVVMExample
//
//  Created by Nikolai Kharkevich on 17.02.2024.
//

import Foundation

open class GenericViewModel<State: ViewStateProtocol>: NSObject {
    
    public let store: GenericStore<State>
    
    public var state: State {
        return store.state
    }
    
    private var subscribers: [AnyWeakSubscriber<GenericStateSubscription<State>>] = []
    
    // MARK: - Init
    
    public init(store: GenericStore<State>) {
        self.store = store
    }

    // MARK: - Subscriptions
    
    public func subscribe<View: StatefulView>(view: View) where View.State == State {
        guard !isSubscribed(object: view) else {
            return
        }
        let subscription = store.subscribe { [weak view] state in
            guard let view = view else {
                return
            }
            switch view.renderPolicy {
            case .possible:
                view.render(state: state)
                
            case .notPossible(let error):
                switch error {
                case .viewNotReady:
                    break
                }
            }
        }
        
        let subscriber = AnyWeakSubscriber(object: view, handler: subscription)
        subscribers.append(subscriber)
    }

    public func unsubscribe<V: StatefulView>(view: V) where V.State == State {
        subscribers.forEach {
            if $0.object.value === view || $0.object.value === nil {
                $0.handler.stop()
            }
        }
        subscribers.removeAll { $0.object.value === view || $0.object.value == nil }
    }
    
    private func isSubscribed(object: AnyObject) -> Bool {
        return subscribers.contains(where: { $0.object.value === object })
    }
}
