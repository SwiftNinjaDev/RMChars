//
//  CharListViewState.swift
//  RMChars
//
//  Created by Nikolai Kharkevich on 01.05.2024.
//

import RMEntities
import SwiftUI

enum CharListoViewState: ViewState {
    case loading
    case loaded(Success)
    case error(NetworkError)
    
    struct Success {
        var sections: [CharactersSection]
    }
}

enum CharacterStatus: String, CaseIterable {
    
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "Unknown"

    init?(from status: RMCharacter.Status) {
        
        switch status {
        case .alive:
            self = .alive
        case .dead:
            self = .dead
        case .unknown:
            self = .unknown
        }
    }
    
    var backgroundColor: Color {
        switch self {
        case .alive:
            return .blue
        case .dead:
            return .red
        case .unknown:
            return .gray
        }
    }
}
