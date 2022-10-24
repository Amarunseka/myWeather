//
//  SevenDaysForecastTableViewCell.swift
//  myWeather
//
//  Created by Миша on 04.08.2022.
//

import UIKit

class SevenDaysForecastTableViewCell: UITableViewCell {
    // MARK: - Initial properties
    var data: Forecast? {
        didSet {
            guard let data = data else {return}
            dateLabel.text = data.date.toDate().toString(type: .shortDate)
            humidLabel.text = "\(data.parts.day.humidity)%"
            descriptionWeatherLabel.text = data.parts.day.condition
            
            let icon = WeatherConditionIcons(iconName: data.parts.day.condition)
            precipitationsImageView.image = icon.icon

            let max = Converter.convertDegreeScale(data.parts.day.tempMax ?? 00)
            let min = Converter.convertDegreeScale(data.parts.night.tempMin ?? 00)
            tempLabel.text = "\(min)˚-\(max)˚"
        }
    }
    
    private let sizes = SizesStorage.self

    private lazy var dateLabel = UILabel.setColorLabel(text: "", fontSize: sizes.fontSizes.bigFontSize, fontStyle: .regular, fontColor: .systemGray)
    private lazy var humidLabel = UILabel.setColorLabel(text: "", fontSize: sizes.fontSizes.standartFontSize, fontStyle: .regular, fontColor: .specialDarkBlue)
    private lazy var dateAndHumidStackView = UIStackView.set(subViews: [dateLabel, humidLabel], axis: .vertical, spacing: 3)
    
    private lazy var descriptionWeatherLabel = UILabel.setBlackLabel(text: "", fontSize: sizes.fontSizes.bigFontSize, fontStyle: .regular)
    private lazy var tempLabel = UILabel.setBlackLabel(text: "", fontSize: sizes.fontSizes.titleFontSize, fontStyle: .regular)
    private lazy var descriptionAndTempStackView = UIStackView.set(subViews: [descriptionWeatherLabel, tempLabel], axis: .horizontal, spacing: 0)
    
    private lazy var precipitationsImageView = UIImageView.setImage("rainIcon")

    // MARK: - Life cycle
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
        dateAndHumidStackView.alignment = .lastBaseline
        descriptionAndTempStackView.distribution = .equalSpacing
        
        backgroundColor = .specialLightBlue
        layer.cornerRadius = 5
        clipsToBounds = true
        
        [
            dateAndHumidStackView,
            descriptionAndTempStackView,
            precipitationsImageView
        ].forEach{
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
    }

    // MARK: - Public methods
}


// MARK: - Set constraints
extension SevenDaysForecastTableViewCell {
    private func setConstraints(){

        NSLayoutConstraint.activate([
            dateAndHumidStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: sizes.standartSpacingSizes.sideSpacing),
            dateAndHumidStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0),
            
            descriptionAndTempStackView.leadingAnchor.constraint(equalTo: dateAndHumidStackView.trailingAnchor, constant: sizes.standartSpacingSizes.sideSpacing),
            descriptionAndTempStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
            descriptionAndTempStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0),
            
            precipitationsImageView.topAnchor.constraint(equalTo: descriptionAndTempStackView.centerYAnchor, constant: 0),
            precipitationsImageView.trailingAnchor.constraint(equalTo: dateAndHumidStackView.leadingAnchor, constant: sizes.fontSizes.smallFontSize),
            precipitationsImageView.heightAnchor.constraint(equalToConstant: sizes.iconSizes.middle),
            precipitationsImageView.widthAnchor.constraint(equalToConstant: sizes.iconSizes.middle),
        ])
    }
}
