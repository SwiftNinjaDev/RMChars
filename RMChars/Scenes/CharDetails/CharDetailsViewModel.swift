//
//  CharDetailsViewModel.swift
//  RMChars
//
//  Created by Nikolai Kharkevich on 01.05.2024.
//

import Foundation
import RMEntities
import SDWebImage

typealias CharDetailsStore = Store<CharDetailsViewState>

final class CharDetailsViewModel: ViewModel<CharDetailsViewState> {
    
    struct Dependencies {
        let charNetService: CharacterServiceProtocol
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
        dependencies.charNetService.fetchCharacterDetail(
            id: inputData.charId
        ) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let data):
                self.handleResponse(data)
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension CharDetailsViewModel {
    
    private func handleResponse(_ response: RMCharacter) {
        guard let imageUrl = URL(string: response.image) else {
            // Handle invalid URL
            return
        }
        
        SDWebImageManager.shared.loadImage(
            with: imageUrl,
            options: .highPriority,
            progress: nil) { [weak self] (image, _, _, _, _, _) in
                guard let self else { return }
                
                guard let image = image else {
                    return
                }
                
                let successData = CharDetailsViewState.CharacterDetails(
                    image: image,
                    name: response.name,
                    location: response.location?.name,
                    gender: response.gender?.rawValue,
                    species: response.species
                )
                self.store.change(state: .loaded(successData))
            }
    }
}
