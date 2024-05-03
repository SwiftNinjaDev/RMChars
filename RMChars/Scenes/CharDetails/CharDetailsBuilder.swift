//
//  CharDetailsBuilder.swift
//  RMChars
//
//  Created by Nikolai Kharkevich on 01.05.2024.
//

import UIKit
import NetServiceKit

final class CharDetailsBuilder {
    
    private let inputData: CharDetailsInputData
    
    init(inputData: CharDetailsInputData) {
        self.inputData = inputData
    }
    
    func build() -> UIViewController {
        let router = CharDetailsRouter()
        
        let networkService = NetworkService()
        let charNetService = CharacterService(networkService: networkService)
        
        let viewModel = CharDetailsViewModel(
            store: CharDetailsStore(initialState: .loading),
            router: router,
            inputData: inputData,
            dependencies: .init(charNetService: charNetService)
        )
        let viewController = CharDetailsViewController(viewModel: viewModel)
        
        router.view = viewController
        
        return viewController
    }
}
