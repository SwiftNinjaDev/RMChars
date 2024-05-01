//
//  CharListBuilder.swift
//  RMChars
//
//  Created by Nikolai Kharkevich on 01.05.2024.
//

import UIKit
import NetServiceKit

final class CharListBuilder {
    
    private let inputData: CharListInputData
    
    init(inputData: CharListInputData) {
        self.inputData = inputData
    }
    
    func build() -> UIViewController {
        let router = CharListRouter()
        
        let networkService = NetworkService()
        let charNetService = CharacterService(networkService: networkService)
        
        let viewModel = CharListViewModel(
            store: CharListStore(initialState: .loading),
            router: router,
            inputData: inputData,
            dependencies: .init(charNetService: charNetService)
        )
        
        let viewController = CharListViewController(viewModel: viewModel)
        
        router.view = viewController
        
        return viewController
    }
}
