//
//  CharDetailsViewState.swift
//  RMChars
//
//  Created by Nikolai Kharkevich on 01.05.2024.
//

import UIKit

enum CharDetailsViewState: ViewState {
    case loading
    case loaded(CharacterDetails)
    case error(NetworkError)
    
    struct CharacterDetails {
        let image: UIImage
        let name: String
        let location: String?
        let gender: String?
        let species: String
        let status: CharacterStatus?
    }
}
