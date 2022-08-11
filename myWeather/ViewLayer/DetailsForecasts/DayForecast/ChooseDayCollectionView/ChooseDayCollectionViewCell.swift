//
//  ChooseDayCollectionViewCell.swift
//  myWeather
//
//  Created by Миша on 09.08.2022.
//

import UIKit

class ChooseDayCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Initial properties
    let nameLabel = UILabel.setBlackLabel(text: "__/__ __", fontSize: 16, fontStyle: .regular)
    
    // MARK: - Life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
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
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        layer.cornerRadius = 5
        layer.borderWidth = 1
        layer.borderColor = UIColor.systemGray2.cgColor
        clipsToBounds = true


        [nameLabel
        ].forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.textAlignment = .center
        }
    }
}


// MARK: - Public methods



// MARK: - Set constraints
extension ChooseDayCollectionViewCell{
    private func setConstraints(){
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
        ])
    }
}
