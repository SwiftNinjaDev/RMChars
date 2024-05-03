//
//  CharactersTableViewCell.swift
//  RMChars
//
//  Created by Nikolai Kharkevich on 02.05.2024.
//

import UIKit
import SDWebImage

class CharactersTableViewCell: UITableViewCell {

    // MARK: - Subviews
    
    private let containerView: UIView = .build {
        $0.layer.borderWidth = 0.5
        $0.layer.borderColor = UIColor.lightGray.cgColor
        $0.roundCorners(.allCorners, radius: 12)
    }
    
    private lazy var containerStackView: UIStackView = .build {
        $0.axis = .horizontal
        $0.alignment = .leading
        $0.spacing = 16
        [
            charImageView,
            infoStackView
        ].forEach($0.addArrangedSubview)
    }
    
    private let charImageView: UIImageView = .build {
        $0.contentMode = .scaleAspectFit
        $0.roundCorners(.allCorners, radius: 8)
    }
    
    private lazy var infoStackView: UIStackView = .build {
        $0.axis = .vertical
        $0.alignment = .top
        $0.spacing = 8
        [
            nameLabel,
            speciesLabel
        ].forEach($0.addArrangedSubview)
    }
    
    private let nameLabel: UILabel = .build {
        $0.font = .systemFont(ofSize: 18, weight: .semibold)
        $0.textColor = .label
    }

    private let speciesLabel: UILabel = .build {
        $0.font = .systemFont(ofSize: 16, weight: .medium)
        $0.textColor = .secondaryLabel
    }

    // MARK: - View lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: String(describing: Self.self))
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
        speciesLabel.text = nil
        charImageView.image = nil
    }

    // MARK: - Private functions
    
    private func setup() {
        contentView.addSubview(containerView)
        containerView.addSubview(containerStackView)
        setupConstraints()
        setupDesign()
    }

    private func setupConstraints() {
        
        containerView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.verticalEdges.equalToSuperview().inset(6)
        }
        
        containerStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(16)
        }
        
        charImageView.snp.makeConstraints { make in
            make.size.equalTo(80)
        }
    }

    private func setupDesign() {
        selectionStyle = .none
        backgroundColor = .clear
        contentView.backgroundColor = .white
    }
}

// MARK: - Config

extension CharactersTableViewCell {
    
    func configure(item: CharactersCellItem) {
        nameLabel.text = item.name
        speciesLabel.text = item.species
        charImageView.sd_setImage(
            with: item.imageURL,
            placeholderImage: .init(systemName: "photo.circle")?.withTintColor(.lightGray, renderingMode: .alwaysOriginal)
        )
    }
}
