//
//  CharListViewController.swift
//  RMChars
//
//  Created by Nikolai Kharkevich on 01.05.2024.
//

import UIKit

final class CharListViewController: ViewModelController<CharListoViewState, CharListViewModel> {
    
    private var lastSelectedStatus: CharacterStatus?
    
    // MARK: - Views
    
    private lazy var collectionView: DynamicCollectionView = {
        let layout = LeftAlignedCollectionViewFlowLayout(minimumLineSpacing: 8, minimumInteritemSpacing: 8)
        layout.scrollDirection = .vertical
        let collectionView = DynamicCollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(StatusCollectionViewCell.self, forCellWithReuseIdentifier: StatusCollectionViewCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.allowsMultipleSelection = false
        collectionView.allowsSelection = true
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
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
        title = "Characters"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func addSubviews() {
        view.addSubview(collectionView)
        view.addSubview(tableView)
    }
    
    private func setupConstraints() {
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(8)
            make.horizontalEdges.equalToSuperview().inset(16)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom).offset(16)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.bottom.equalToSuperview()
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

// MARK: - Collection View methods

extension CharListViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return CharacterStatus.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: StatusCollectionViewCell.identifier,
            for: indexPath
        ) as? StatusCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let status = CharacterStatus.allCases[indexPath.row]
        
        cell.configure(status: status)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let currentStatus = CharacterStatus.allCases[indexPath.row]

        if lastSelectedStatus == currentStatus {
            collectionView.deselectItem(at: indexPath, animated: true)
            viewModel.updateStatus(nil, isSelected: false)
            lastSelectedStatus = nil
        } else {
            let previousStatus = lastSelectedStatus
            lastSelectedStatus = currentStatus
            viewModel.updateStatus(currentStatus, isSelected: true)
            if let lastStatus = previousStatus,
               let lastIndex = CharacterStatus.allCases.firstIndex(of: lastStatus) {
                let lastIndexPath = IndexPath(row: lastIndex, section: 0)
                collectionView.deselectItem(at: lastIndexPath, animated: true)
            }
        }
    }
}
