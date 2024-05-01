//
//  CharDetailsViewModel.swift
//  RMChars
//
//  Created by Nikolai Kharkevich on 01.05.2024.
//

typealias CharDetailsStore = Store<CharDetailsViewState>

final class CharDetailsViewModel: ViewModel<CharDetailsViewState> {
    struct Dependencies {
        // put your dependencies here
    }

    private let router: CharDetailsRouterProtocol
    private let inputData: CharDetailsInputData
    private let dependencies: CharDetailsViewModel.Dependencies

    // MARK: - Init
    
    init(
        store: CharDetailsStore,
        router: CharDetailsRouterProtocol,
        inputData: CharDetailsInputData,
        dependencies: CharDetailsViewModel.Dependencies
    ) {
        self.router = router
        self.inputData = inputData
        self.dependencies = dependencies
        super.init(store: store)
    }
    
    // MARK: - View Output
    
    func fetchData() {
        print(inputData.charId)
        store.change(state: .loading)
    }
}
