//
//  PartOfTheDayTableViewCell.swift
//  myWeather
//
//  Created by Миша on 09.08.2022.
//

import UIKit

class PartOfTheDayTableViewCell: UITableViewCell {
    
    // MARK: - Initial properties
    var data: ModelTableView? {
        didSet {
            guard let data = data else {return}
            self.descriptionLabel.text = data.condition
            nameLabel.setIconWithSize(text: data.name.rawValue, icon: data.name.icon, width: sizes.iconSizes.middle, height: sizes.iconSizes.middle)
        }
    }
    
    private let sizes = SizesStorage.self

    private lazy var nameLabel: UILabel = {
        let label = UILabel.setBlackLabel(text: "___", fontSize: sizes.fontSizes.bigFontSize, fontStyle: .regular)
        label.setIconWithSize(text: "___", icon: UIImage.termSun, width: sizes.iconSizes.middle, height: sizes.iconSizes.middle)
        return label
    }()
    
    private lazy var descriptionLabel = UILabel.setBlackLabel(text: "___", fontSize: sizes.fontSizes.bigFontSize, fontStyle: .regular)

    // MARK: - Life )
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setConstraints()
    }
    
    // MARK: - Private methods
    private func setupView(){
        self.backgroundColor = .clear

        [nameLabel,
         descriptionLabel
        ].forEach{
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
    }
    // MARK: - Public methods
}

// MARK: - Set constraints
extension PartOfTheDayTableViewCell {
    private func setConstraints(){
        NSLayoutConstraint.activate([
            nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            
            descriptionLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -sizes.standartSpacingSizes.sideSpacing),
        ])
    }
}
