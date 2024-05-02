//
//  CharListViewState.swift
//  RMChars
//
//  Created by Nikolai Kharkevich on 01.05.2024.
//

import RMEntities

enum CharListoViewState: ViewState {
    case loading
    case loaded(Success)
    case error(NetworkError)
    
    struct Success {
        var sections: [CharactersSection]
        var statusList: [String]
    }
}
