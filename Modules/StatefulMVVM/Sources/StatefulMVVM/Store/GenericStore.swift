//
//  Store.swift
//

import Foundation

public final class GenericStore<State: StoreStateProtocol> {

    private var subscriptions = NSHashTable<GenericStateSubscription<State>>.weakObjects()

    private let stateLock = NSLock()

    public private(set) var state: State {
        get {
            stateLock.sync {
                _state
            }
        }
        set {
            stateLock.lock()
            let oldValue = _state
            _state = newValue
            stateLock.unlock()

            stateDidChange(oldState: oldValue, newState: newValue)
        }
    }

    public var isEmpty: Bool {
        return subscriptions.count == 0
    }

    private var _state: State

    public var storeIdentifier: String {
        return String(describing: self)
    }

    private var isApplyingUndoOrRedo = false
    private var undoStack = [UndoRedoState<State>]()
    private var redoStack = [UndoRedoState<State>]()

    public init(initialState: State) {
        _state = initialState
    }

    public func change(state: State) {
        self.state = state
    }

    /// `func subscribe(_:)` is not thread safe, so subscription should be done from single queue, preferably main.
    public func subscribe(fireLastKnownState: Bool = true, block: @escaping (State) -> Void) -> GenericStateSubscription<State> {
        let subscription = GenericStateSubscription(block)
        subscriptions.add(subscription)
        if fireLastKnownState {
            subscription.fire(state)
        }
        return subscription
    }

    private func stateDidChange(oldState: State, newState: State) {
        if !isApplyingUndoOrRedo {
            let undoState = UndoRedoState(oldState: oldState, newState: newState)
            undoStack.append(undoState)
            redoStack = []
        }

        debugLog("[\(storeLogDescription())] State change: \(newState.logDescription)")
        subscriptions.allObjects.forEach {
            $0.fire(newState)
        }
    }

    func undo() {
        debugLog("[\(storeLogDescription())] Undo state")
        guard let undoRedoState = self.undoStack.popLast() else { return }
        applyUndoRedoState(undoRedoState)
        redoStack.append(undoRedoState.flip())
    }

    func redo() {
        debugLog("[\(storeLogDescription())] Redo state")
        guard let undoRedoState = self.redoStack.popLast() else { return }
        applyUndoRedoState(undoRedoState)
        undoStack.append(undoRedoState.flip())
    }

    private func applyUndoRedoState(_ undoRedoState: UndoRedoState<State>) {
        isApplyingUndoOrRedo = true
        state = undoRedoState.oldState
        isApplyingUndoOrRedo = false
    }

    private func storeLogDescription() -> String {
        return String(describing: type(of: self))
    }

    private func debugLog(_ str: @autoclosure () -> String) {
        #if DEBUG || TEST
            print(str())
        #endif
    }
}

private struct UndoRedoState<T: StoreStateProtocol> {
    let oldState: T
    let newState: T

    func flip() -> UndoRedoState<T> {
        return UndoRedoState(oldState: newState, newState: oldState)
    }
}
