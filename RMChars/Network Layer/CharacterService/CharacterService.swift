//
//  CharacterService.swift
//  RMChars
//
//  Created by Nikolai Kharkevich on 01.05.2024.
//

import RMEntities
import NetServiceKit

typealias NetworkError = NetServiceKit.NetworkError

final class CharacterService: CharacterServiceProtocol {
    private let networkService: Networkable

    init(networkService: Networkable) {
        self.networkService = networkService
    }

    func fetchCharacters(
        page: Int? = nil,
        status: String? = nil,
        completion: @escaping (Result<CharactersResponse, NetworkError>) -> Void
    ) {
        let endpoint = CharacterEndpoint(page: page, status: status)
        networkService.sendRequest(endpoint: endpoint, resultHandler: completion)
    }
    
    func fetchCharacterDetail(
        id: Int,
        completion: @escaping (Result<RMCharacter, NetworkError>) -> Void
    ) {
        let endpoint = CharacterEndpoint.characterDetail(id: id)
        networkService.sendRequest(endpoint: endpoint, resultHandler: completion)
    }
}
