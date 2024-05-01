//
//  CharListViewController.swift
//  RMChars
//
//  Created by Nikolai Kharkevich on 01.05.2024.
//

import UIKit

final class CharListViewController: ViewModelController<CharListoViewState, CharListViewModel> {
    
    // MARK: - Views

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchData()
    }
    
    override func setupUI() {
        super.setupUI()
        // perform additional UI setup here
        view.backgroundColor = .blue
    }
    
    override func render(state: CharListoViewState) {
        super.render(state: state)
        
        switch state {
        case .loading:
            break
        case .loaded(let data):
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.viewModel.showCharDetails(with: "")
            }
            print(data)
        case .error(let error):
            print(error)
        }
    }
}
