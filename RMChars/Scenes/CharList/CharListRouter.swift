//
//  CharListRouter.swift
//  RMChars
//
//  Created by Nikolai Kharkevich on 01.05.2024.
//

import UIKit

enum MoreInfoRoute {
    case charDetails(id: Int)
}

protocol CharListRouterProtocol {
    func navigate(to route: MoreInfoRoute)
}

final class CharListRouter: CharListRouterProtocol {
    
    weak var view: UIViewController?
    
    func navigate(to route: MoreInfoRoute) {
        switch route {
        case .charDetails(let id):
            goToCharDetails(id)
        }
    }
}

extension CharListRouter {
    
    private func goToCharDetails(_ id: Int) {
        let inputData = CharDetailsInputData(charId: id)
        let vc = CharDetailsBuilder(inputData: inputData).build()
        
        view?.present(vc, animated: true)
    }
}
