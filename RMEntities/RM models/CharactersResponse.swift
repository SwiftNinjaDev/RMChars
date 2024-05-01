//
//  CharactersResponse.swift
//  RMEntities
//
//  Created by Nikolai Kharkevich on 01.05.2024.
//

import Foundation

// Model for the entire API response
public struct CharactersResponse: Decodable {
   public let info: RickAndMortyInfo
   public let results: [Character]
}

// Model for the API's pagination info
public struct RickAndMortyInfo: Decodable {
    public let count: Int
    public let pages: Int
    public let next: String?
    public let prev: String?
}

// Model for a character
public struct Character: Decodable, Identifiable {
    public let id: Int
    public let name: String
    public let status: String
    public let species: String
    public let image: String
}
