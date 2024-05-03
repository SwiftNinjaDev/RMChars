//
//  CharactersCellItem.swift
//  RMChars
//
//  Created by Nikolai Kharkevich on 02.05.2024.
//

import Foundation
import RMEntities

struct CharactersSection {
    
    var sectionType: CharactersSectionType
    var items: [CharactersCellItem]
}

struct CharactersCellItem: Hashable {

    let id: Int
    let name: String
    let imageURL: URL?
    let species: String

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)

    }

    static func == (lhs: CharactersCellItem, rhs: CharactersCellItem ) -> Bool {
        lhs.id == rhs.id
    }
    
    init(id: Int, name: String, imageURL: URL, species: String) {
        self.id = id
        self.name = name
        self.imageURL = imageURL
        self.species = species
    }
    
    init(response: RMCharacter) {
        self.id = response.id
        self.name = response.name
        self.imageURL = URL(string: response.image)
        self.species = response.species
    }
}
