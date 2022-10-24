//
//  HoursForecastCollectionViewCell.swift
//  myWeather
//
//  Created by Миша on 04.08.2022.
//

import UIKit

class HoursForecastCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Initial properties
    var data: Hour? {
        didSet {
            guard let data = data else {return}
            let mode = UserDefaultsManager.shared.settings.timeFormatMode
            var time = ""
            mode == 0
            ? (time = (data.hourTs).toDate().toString(type: .hour))
            : (time = "\((data.hourTs).toDate().toString(type: .hour)):00")
            timeLabel.text = "\(time)"
            
            let temp = Converter.convertDegreeScale(data.temp)
            tempLabel.text = "\(temp)˚"
            
            let icon = WeatherConditionIcons(iconName: data.condition)
            precipitationsImageView.image = icon.icon
        }
    }
    
    override var isSelected: Bool {
        didSet {
            if self.isSelected {
                backgroundColor = .specialDarkBlue
                timeLabel.textColor = .white
                tempLabel.textColor = .white
            } else {
                backgroundColor = .white
                timeLabel.textColor = .black
                tempLabel.textColor = .black
            }
        }
    }
    
    private let sizes = SizesStorage.self
    
    private lazy var timeLabel = UILabel.setBlackLabel(text: "", fontSize: sizes.fontSizes.bigFontSize, fontStyle: .regular)
    private lazy var precipitationsImageView = UIImageView.setImage("sunIcon")
    private lazy var tempLabel = UILabel.setBlackLabel(text: "", fontSize: sizes.fontSizes.bigFontSize, fontStyle: .regular)

    // MARK: - Life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.cornerRadius = frame.size.width / 2
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.systemGray2.cgColor
        self.clipsToBounds = true
    }


// MARK: - Private methods
    private func setupView(){
        backgroundColor = nil
        timeLabel.adjustsFontSizeToFitWidth = true
        
        [timeLabel,
         tempLabel
        ].forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.textAlignment = .center
        }
        
        precipitationsImageView.contentMode = .scaleAspectFit
        precipitationsImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(precipitationsImageView)
    }
}


// MARK: - Public methods



// MARK: - Set constraints
extension HoursForecastCollectionViewCell{
    private func setConstraints(){
        NSLayoutConstraint.activate([
            precipitationsImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0),
            precipitationsImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 0),
            precipitationsImageView.heightAnchor.constraint(equalToConstant: sizes.iconSizes.small),
            precipitationsImageView.widthAnchor.constraint(equalToConstant: sizes.iconSizes.small),

            timeLabel.bottomAnchor.constraint(equalTo: precipitationsImageView.topAnchor, constant: 0),
            timeLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 0),

            tempLabel.topAnchor.constraint(equalTo: precipitationsImageView.bottomAnchor, constant: 2),
            tempLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 0),
        ])
    }
}
