//
//  CharDetailsRouter.swift
//  RMChars
//
//  Created by Nikolai Kharkevich on 01.05.2024.
//

import UIKit

enum CharDetailsRoute {
    
}

protocol CharDetailsRouterProtocol {
    func navigate(to route: CharDetailsRoute)
}

final class CharDetailsRouter: CharDetailsRouterProtocol {
    
    weak var view: UIViewController?
    
    func navigate(to route: CharDetailsRoute) {
        
    }
}
