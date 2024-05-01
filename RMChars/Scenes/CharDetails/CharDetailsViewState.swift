//
//  CharDetailsViewState.swift
//  RMChars
//
//  Created by Nikolai Kharkevich on 01.05.2024.
//

enum CharDetailsViewState: ViewState {
    case loading
    case loaded(Success)
    case error(Failure)
    
    struct Success {
        // fulfill with required fields
    }
    
    struct Failure: Error {
        // fulfill with required fields
    }
}
