//
//  DailyForecastDetailsView.swift
//  myWeather
//
//  Created by Миша on 08.08.2022.
//

import UIKit

class DailyForecastDetailsView: UIView {
    
    // MARK: - Initial properties
    var iconImageView: UIImageView
    var nameLabel: UILabel
    var descriptionLabel: UILabel?

    // MARK: - Life cycle
    init(icon: String, name: String, description: String?){
        self.iconImageView = UIImageView.setImage(icon)
        self.nameLabel = UILabel.setBlackLabel(text: name, fontSize: 14, fontStyle: .regular)
        
        if let description = description {
            self.descriptionLabel = UILabel.setColorLabel(text: description,
                                                          fontSize: 12,
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
        setFrames()
        setConstraints()
    }

    // MARK: - Private methods
    private func setupView(){
        backgroundColor = .clear
        [iconImageView,
         nameLabel,
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
    
    private func setFrames(){
        iconImageView.frame.size.height = nameLabel.frame.size.height
        iconImageView.frame.size.width = iconImageView.frame.size.height
        iconImageView.contentMode = .scaleAspectFit
    }

    // MARK: - Public methods

}

// MARK: - Set constraints
extension DailyForecastDetailsView {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            iconImageView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            iconImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: iconImageView.frame.size.width + 10),
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
