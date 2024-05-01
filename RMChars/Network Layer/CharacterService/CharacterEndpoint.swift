//
//  CharacterEndpoint.swift
//  RMChars
//
//  Created by Nikolai Kharkevich on 01.05.2024.
//

import Foundation
import NetServiceKit

struct CharacterEndpoint: Endpoint {
    
    var scheme: String = "https"
    var host: String = "rickandmortyapi.com"
    var path: String = "/api/character"
    
    var method: RequestMethod = .get
    
    var header: [String: String]?
    var queryParams: [String: String]?
    var body: [String: String]?
    var pathParams: [String: String]?

    init(page: Int? = nil, status: String? = nil) {
        var params = [String: String]()
        if let page = page {
            params["page"] = String(page)
        }
        if let status = status {
            params["status"] = status
        }
        queryParams = params
    }
}
