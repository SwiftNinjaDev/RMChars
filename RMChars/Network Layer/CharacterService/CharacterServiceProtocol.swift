//
//  CharacterServiceProtocol.swift
//  RMChars
//
//  Created by Nikolai Kharkevich on 01.05.2024.
//

import RMEntities
import NetServiceKit

protocol CharacterServiceProtocol {
    
    func fetchCharacters(
        page: Int?,
        status: String?,
        completion: @escaping (Result<CharactersResponse, NetworkError>) -> Void
    )
    
    func fetchCharacterDetail(
        id: Int,
        completion: @escaping (Result<RMCharacter, NetworkError>) -> Void
    )
}
