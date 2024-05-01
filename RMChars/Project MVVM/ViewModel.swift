//
//  ViewModel.swift
//  RMChars
//
//  Created by Nikolai Kharkevich on 01.05.2024.
//

import StatefulMVVM

open class ViewModel<State: ViewState>: GenericViewModel<State> {
    
    public func change (state: State) {
        store.change(state: state)
    }
}
