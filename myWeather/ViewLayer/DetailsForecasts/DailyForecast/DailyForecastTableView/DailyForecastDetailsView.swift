//
//  DailyForecastDetailsView.swift
//  myWeather
//
//  Created by Миша on 08.08.2022.
//

import UIKit

class DailyForecastDetailsView: UIView {
    
    // MARK: - Initial properties
    var nameLabel: UILabel
    var descriptionLabel: UILabel?
    
    // MARK: - Life cycle
    init(icon: String, name: String, description: String?){
        let sizes = SizesStorage.self
        
        let label: UILabel = {
            let label = UILabel.setBlackLabel(text: name, fontSize: sizes.fontSizes.standartFontSize, fontStyle: .regular)
            label.setIconWithSize(text: name, icon: UIImage(named: icon), width: sizes.iconSizes.middle, height: sizes.iconSizes.middle)
            return label
        }()
        
        self.nameLabel = label
        
        if let description = description {
            self.descriptionLabel = UILabel.setColorLabel(text: description,
                                                          fontSize: sizes.fontSizes.standartFontSize,
                                                          fontStyle: .regular,
                                                          fontColor: .systemGray)
        }
        super.init(frame: .zero)
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
        [nameLabel,
        ].forEach{
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
        
        guard let descriptionLabel = descriptionLabel else {return}
        [descriptionLabel].forEach{
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
    }
    // MARK: - Public methods
}

// MARK: - Set constraints
extension DailyForecastDetailsView {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
        ])
        
        guard let descriptionLabel = descriptionLabel else {return}
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            nameLabel.trailingAnchor.constraint(lessThanOrEqualTo: descriptionLabel.leadingAnchor, constant: -5),
        ])
    }
}
