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
        let charNetService: CharacterServiceProtocol
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
    
    func fetchCharacters(page: Int? = 0, status: String? = nil) {
        store.change(state: .loading)
        
        dependencies.charNetService.fetchCharacters(
            page: page,
            status: status
        ) { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let response):
                let successViewState = self.prepareViewState(from: response)
                store.change(state: .loaded(successViewState))
            case .failure(let error):
                store.change(state: .error(error))
            }
        }
        
    }
}

// MARK: Navigation
extension CharListViewModel {
    
    func showCharDetails(with id: Int) {
        router.navigate(to: .charDetails(id: id))
    }
}

// MARK: Prepare View state
extension CharListViewModel {
    
    private func prepareViewState(from response: CharactersResponse) -> CharListoViewState.Success {
        CharListoViewState.Success(characters: response.results)
    }
}
