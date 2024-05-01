//
//  CharListViewModel.swift
//  RMChars
//
//  Created by Nikolai Kharkevich on 01.05.2024.
//

import RMEntities

typealias CharListStore = Store<CharListoViewState>

final class CharListViewModel: ViewModel<CharListoViewState>, MoreInfoViewOutput {
    struct Dependencies {
        // put your dependencies here
    }

    private let router: CharListRouterProtocol
    private let inputData: CharListInputData
    private let dependencies: CharListViewModel.Dependencies

    // MARK: - Init
    
    init(
        store: CharListStore,
        router: CharListRouterProtocol,
        inputData: CharListInputData,
        dependencies: CharListViewModel.Dependencies
    ) {
        self.router = router
        self.inputData = inputData
        self.dependencies = dependencies
        super.init(store: store)
    }
}

// MARK: Network
extension CharListViewModel {
    
    func fetchData() {
        let successViewState = self.prepareViewState()
        store.change(state: .loaded(successViewState))
    }
}

// MARK: Navigation
extension CharListViewModel {
    
    func showCharDetails(with id: String) {
        router.navigate(to: .charDetails(id: id))
    }
}

// MARK: Prepare View state
extension CharListViewModel {
    
    private func prepareViewState() -> CharListoViewState.Success {
        CharListoViewState.Success()
    }
}
