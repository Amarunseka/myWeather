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
            self.nameLabel.text = data.name.rawValue
            self.iconImageView.image = data.name.icon
            self.descriptionLabel.text = data.condition
        }
    }
    
    private var iconImageView = UIImageView.setImage("termSun")
    private var nameLabel = UILabel.setBlackLabel(text: "___", fontSize: 12, fontStyle: .regular)
    private var descriptionLabel = UILabel.setBlackLabel(text: "___", fontSize: 16, fontStyle: .regular)

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
        setFrames()
        setConstraints()
    }
    
    // MARK: - Private methods
    private func setupView(){
        self.backgroundColor = .clear
        let size: CGFloat = 20
        iconImageView.frame.size = CGSize(width: size, height: size)

        
        
        [iconImageView,
         nameLabel,
         descriptionLabel
        ].forEach{
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
    }
    
    private func setFrames(){
        let size: CGFloat = 20
        iconImageView.frame.size = CGSize(width: size, height: size)

    }
}



// MARK: - Public methods



// MARK: - Set constraints
extension PartOfTheDayTableViewCell {
    private func setConstraints(){
        NSLayoutConstraint.activate([
            iconImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            iconImageView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0),

            nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            
            descriptionLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            descriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
        ])
    }
}
