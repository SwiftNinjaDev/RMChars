//
//  CharListRouter.swift
//  RMChars
//
//  Created by Nikolai Kharkevich on 01.05.2024.
//

import UIKit

enum MoreInfoRoute {
    case charDetails(id: String)
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
    
    private func goToCharDetails(_ id: String) {
        let inputData = CharDetailsInputData(charId: id)
        let vc = CharDetailsBuilder(inputData: inputData).build()
        
        guard let navigationController = view?.navigationController else { return }
        navigationController.pushViewController(vc, animated: true)
    }
}
