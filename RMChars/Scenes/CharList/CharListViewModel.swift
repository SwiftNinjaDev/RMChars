//
//  CharListViewModel.swift
//  RMChars
//
//  Created by Nikolai Kharkevich on 01.05.2024.
//

import RMEntities
import UIKit

typealias CharListStore = Store<CharListoViewState>

final class CharListViewModel: ViewModel<CharListoViewState>, MoreInfoViewOutput {
    
    struct Dependencies {
        let charNetService: CharacterServiceProtocol
    }

    private let router: CharListRouterProtocol
    private let inputData: CharListInputData
    private let dependencies: CharListViewModel.Dependencies
    
    private var page: Int = 1
    private var shouldStopPagination: Bool = false
    
    private var characters: [RMCharacter] = []

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
    
    func removeAllChars() {
        characters.removeAll()
        page = 1
        shouldStopPagination = false
    }
}

// MARK: Network
extension CharListViewModel {
    
    func fetchCharacters(status: String? = nil) {
          store.change(state: .loading)

          dependencies.charNetService.fetchCharacters(page: page, status: status) { [weak self] result in
              guard let self = self else { return }

              switch result {
              case .success(let data):
                  self.handleResponse(data)
              case .failure(let error):
                  self.shouldStopPagination = true
                  self.store.change(state: .error(error))
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

// MARK: Handle response
extension CharListViewModel {
    
    private func handleResponse(_ response: CharactersResponse) {
        
        if response.results.isEmpty {
            shouldStopPagination = true
        } else {
            characters += response.results
            let successViewState = self.prepareSuccessState(from: characters)
            store.change(state: .loaded(successViewState))
        }
    }
    
    private func prepareCharactersSection(from response: [RMCharacter]) -> CharactersSection {
        CharactersSection(
            sectionType: .items,
            items: response.map { CharactersCellItem(response: $0) }
        )
    }
    
    private func prepareSuccessState(from response: [RMCharacter]) -> CharListoViewState.Success {
        CharListoViewState.Success(
            sections: [prepareCharactersSection(from: response)],
            statusList: []
        )
    }
}

// MARK: Pagination
extension CharListViewModel: UIScrollViewDelegate {
    
    enum PaginationConstants {
        static let itemsOnPage = 20
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let height = scrollView.frame.size.height
        let distanceFromBottom = scrollView.contentSize.height - scrollView.contentOffset.y
        let isPagination = (page * PaginationConstants.itemsOnPage) <= characters.count
        if distanceFromBottom < height && isPagination {
            guard !shouldStopPagination else {
                return
            }

            page += 1
            fetchCharacters()
        }
    }
}

// MARK: TableView Delegate
extension CharListViewModel: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let selectedChar = characters[safe: indexPath.row] else {
            return
        }
        
        showCharDetails(with: selectedChar.id)
    }
}
