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
   public let results: [RMCharacter]
}

// Model for the API's pagination info
public struct RickAndMortyInfo: Decodable {
    public let count: Int
    public let pages: Int
    public let next: String?
    public let prev: String?
}

// Model for a character
public struct RMCharacter: Decodable, Identifiable {
    public let id: Int
    public let name: String
    public let status: Status
    public let species: String
    public let image: String
    public let gender: Gender?
    public let location: Location?
    
    public enum Status: String, Decodable {
        case alive = "Alive"
        case dead = "Dead"
        case unknown = "unknown"
    }
    
    public enum Gender: String, Decodable {
        case female = "Female"
        case male = "Male"
        case genderless = "Genderless"
        case unknown = "unknown"
    }
    
    public struct Location: Decodable {
        public let name: String
        public let url: String
    }
}
