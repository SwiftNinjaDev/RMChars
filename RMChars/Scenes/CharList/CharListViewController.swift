//
//  CharListViewController.swift
//  RMChars
//
//  Created by Nikolai Kharkevich on 01.05.2024.
//

import UIKit

final class CharListViewController: ViewModelController<CharListoViewState, CharListViewModel> {
    
    // MARK: - Views
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.dataSource = self
        table.delegate = self
        return table
    }()
    
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
    }
    
    private func addSubviews() {
        view.addSubview(tableView)
    }
    
    private func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    override func render(state: CharListoViewState) {
        switch state {
        case .loading:
            break
        case .loaded:
            tableView.reloadData()
        case .error(let error):
            print(error)
        }
    }
}

// MARK: - UITableView DataSource and Delegate

extension CharListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard case .loaded(let success) = viewModel.store.state else {
            return 0
        }
        return success.characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if case .loaded(let success) = viewModel.store.state {
            let character = success.characters[indexPath.row]
            cell.textLabel?.text = character.name
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if case .loaded(let success) = viewModel.store.state {
            let character = success.characters[indexPath.row]
            viewModel.showCharDetails(with: character.id)
        }
    }
}
