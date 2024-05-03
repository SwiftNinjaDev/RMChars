//
//  Endpoint.swift
//  
//
//  Created by Nikolai Kharkevich on 01.05.2024.
//

import Foundation

public protocol Endpoint {
    var host: String { get }
    var scheme: String { get }
    var path: String { get }
    var method: RequestMethod { get }
    var header: [String: String]? { get }
    var body: [String: String]? { get }
    var queryParams: [String: String]? { get }
    var pathParams: [String: String]? { get }
}

extension Endpoint {
    var scheme: String {
        return "https"
    }
    var host: String {
        return ""
    }
}
