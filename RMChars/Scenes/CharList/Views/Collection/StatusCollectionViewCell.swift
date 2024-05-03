//
//  StatusCollectionViewCell.swift
//  RMChars
//
//  Created by Nikolai Kharkevich on 02.05.2024.
//

import UIKit

final class StatusCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "\(StatusCollectionViewCell.self)"

    private let statusLabel: UILabel = .build {
        $0.textAlignment = .center
        $0.font = .systemFont(ofSize: 14, weight: .regular)
        $0.textColor = .label
    }
    
    override var isSelected: Bool {
        didSet {
            updateUIForState(isSelected: isSelected)
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        updateUIForState(isSelected: false)
    }

    private func setupViews() {
        setupContentView()
        updateUIForState(isSelected: false)
        
        contentView.addSubview(statusLabel)
        statusLabel.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(12)
            $0.verticalEdges.equalToSuperview().inset(8)
        }
    }
    
    private func setupContentView() {
        contentView.layer.cornerRadius = 12
        contentView.layer.masksToBounds = true
        contentView.layer.borderWidth = 1
    }
    
    private func updateUIForState(isSelected: Bool) {
        if isSelected {
            selectedStateColors()
        } else {
            defaultStateColors()
        }
    }
    
    private func defaultStateColors() {
        contentView.backgroundColor = .white
        contentView.layer.borderColor = UIColor.lightGray.cgColor
        statusLabel.textColor = .black
    }
    
    private func selectedStateColors() {
        contentView.backgroundColor = .blue.withAlphaComponent(0.2)
        contentView.layer.borderColor = UIColor.blue.cgColor
        statusLabel.textColor = .black
    }
}

// MARK: - Config

extension StatusCollectionViewCell {
    
    func configure(status: CharacterStatus) {
        statusLabel.text = status.rawValue
    }
}
