//
//  CharListViewController.swift
//  RMChars
//
//  Created by Nikolai Kharkevich on 01.05.2024.
//

import UIKit

final class CharListViewController: ViewModelController<CharListoViewState, CharListViewModel> {
    
    // MARK: - Views
    
    private lazy var refreshControl: UIRefreshControl = {
        let control = UIRefreshControl(frame: .zero)
        control.addTarget(self, action: #selector(onRefreshRequested), for: .valueChanged)
        return control
    }()
    
    private lazy var tableView: CharactersTableView = .build {
        $0.delegate = viewModel
        $0.refreshControl = refreshControl
        $0.roundCorners(.allCorners, radius: 10)
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        viewModel.fetchCharacters()
    }
    
    override func setupUI() {
        super.setupUI()
        addSubviews()
        setupConstraints()
        view.backgroundColor = .white
        navigationController?.navigationBar.backgroundColor = .white
        navigationItem.title = "Characters"
    }
    
    private func addSubviews() {
        view.addSubview(tableView)
    }
    
    private func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(16)
            make.verticalEdges.equalToSuperview()
        }
    }
    
    @objc
    private func onRefreshRequested(_ control: UIRefreshControl) {
        viewModel.removeAllChars()
        viewModel.fetchCharacters()
        control.endRefreshing()
    }
    
    override func render(state: CharListoViewState) {
        switch state {
        case .loading:
            showIndicatorView()
        case .loaded(let data):
            hideIndicatorView()
            tableView.configure(with: data.sections)
        case .error(let error):
            hideIndicatorView()
            print(error)
        }
    }
}
