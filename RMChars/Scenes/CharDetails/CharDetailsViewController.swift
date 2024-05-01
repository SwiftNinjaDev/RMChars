//
//  CharDetailsViewController.swift
//  RMChars
//
//  Created by Nikolai Kharkevich on 01.05.2024.
//

import UIKit

final class CharDetailsViewController: ViewModelController<CharDetailsViewState, CharDetailsViewModel> {
    
    // MARK: - Views
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchData()
    }
    
    override func setupUI() {
        super.setupUI()
        // perform additional UI setup here
        view.backgroundColor = .red
    }
    
    override func render(state: CharDetailsViewState) {
        super.render(state: state)
        
        switch state {
        case .loading:
            break
        case .loaded(let data):
            print(data)
        case .error(let error):
            print(error)
        }
    }
}
