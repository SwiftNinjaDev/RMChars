//
//  State.swift
//

import Foundation

public protocol StoreStateProtocol: CustomLogDescriptionConvertible { }
public protocol ViewStateProtocol: StoreStateProtocol { }

extension Int: StoreStateProtocol { }
extension Bool: StoreStateProtocol { }

extension Equatable where Self: StoreStateProtocol {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        return false
    }
}
