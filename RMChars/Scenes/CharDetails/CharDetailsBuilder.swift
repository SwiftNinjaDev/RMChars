//
//  CharDetailsBuilder.swift
//  RMChars
//
//  Created by Nikolai Kharkevich on 01.05.2024.
//

import UIKit

final class CharDetailsBuilder {
    
    private let inputData: CharDetailsInputData
    
    init(inputData: CharDetailsInputData) {
        self.inputData = inputData
    }
    
    func build() -> UIViewController {
        let router = CharDetailsRouter()
        
        let viewModel = CharDetailsViewModel(
            store: CharDetailsStore(initialState: .loading),
            router: router,
            inputData: inputData,
            dependencies: .init()
        )
        let viewController = CharDetailsViewController(viewModel: viewModel)
        
        router.view = viewController
        
        return viewController
    }
}
