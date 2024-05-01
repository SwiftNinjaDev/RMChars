//
//  CharListBuilder.swift
//  RMChars
//
//  Created by Nikolai Kharkevich on 01.05.2024.
//

import UIKit

final class CharListBuilder {
    
    private let inputData: CharListInputData
    
    init(inputData: CharListInputData) {
        self.inputData = inputData
    }
    
    func build() -> UIViewController {
        let router = CharListRouter()
        
        let viewModel = CharListViewModel(
            store: CharListStore(initialState: .loading),
            router: router,
            inputData: inputData,
            dependencies: .init()
        )
        let viewController = CharListViewController(viewModel: viewModel)
        
        router.view = viewController
        
        return viewController
    }
}
