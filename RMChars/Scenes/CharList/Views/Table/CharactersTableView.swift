//
//  CharactersTableView.swift
//  RMChars
//
//  Created by Nikolai Kharkevich on 02.05.2024.
//

import UIKit

enum CharactersSectionType {
    case items
}

class CharactersTableView: UITableView {
    
    private lazy var diffableDatasource = makeDataSource()

    override func reloadData() {
        super.reloadData()
        self.invalidateIntrinsicContentSize()
    }

    override var intrinsicContentSize: CGSize {
        self.layoutIfNeeded()
        return self.contentSize
    }

    override var contentSize: CGSize {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }

    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        setup()
        self.dataSource = diffableDatasource
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with sections: [CharactersSection]) {
        updateDataSource(with: sections)
    }

    func updateDataSource(with sections: [CharactersSection]) {
        var snapshot = NSDiffableDataSourceSnapshot<CharactersSectionType, CharactersCellItem>()

        sections.forEach { section in
            snapshot.appendSections([section.sectionType])
            snapshot.appendItems(section.items, toSection: section.sectionType)
        }

        diffableDatasource.defaultRowAnimation = .top
        
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }

            self.diffableDatasource.apply(snapshot, animatingDifferences: false, completion: nil)
        }
    }

    private func makeDataSource() -> UITableViewDiffableDataSource<CharactersSectionType, CharactersCellItem> {
        
        let dataSource = UITableViewDiffableDataSource<CharactersSectionType, CharactersCellItem>(
            tableView: self, cellProvider: { tableView, indexPath, item in
            var cell: UITableViewCell = UITableViewCell()

            let snapshot = self.diffableDatasource.snapshot()
            let sectionIdentifier = snapshot.sectionIdentifiers[indexPath.section]

                switch sectionIdentifier {
                case .items:
                    let itemCell = tableView.dequeueReusableCell(
                        withIdentifier: String(describing: CharactersTableViewCell.self),
                        for: indexPath
                    ) as? CharactersTableViewCell
                    
                    guard let itemCell = itemCell else { return UITableViewCell() }
                    itemCell.configure(item: item)
                    cell = itemCell
                }

            return cell
        })

        return dataSource
    }
    
    private func setup() {
        rowHeight = UITableView.automaticDimension
        backgroundColor = .clear
        separatorStyle = .none
        showsVerticalScrollIndicator = false
        estimatedRowHeight = 70
        register(
            CharactersTableViewCell.self,
            forCellReuseIdentifier: String(describing: CharactersTableViewCell.self)
        )
    }
}
