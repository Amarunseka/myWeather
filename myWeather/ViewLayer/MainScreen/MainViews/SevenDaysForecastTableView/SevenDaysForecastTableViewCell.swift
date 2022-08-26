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

    private let dateLabel = UILabel.setColorLabel(text: "", fontSize: 16, fontStyle: .regular, fontColor: .systemGray)
    private let humidLabel = UILabel.setColorLabel(text: "", fontSize: 14, fontStyle: .regular, fontColor: .specialDarkBlue)
    private let descriptionWeatherLabel = UILabel.setBlackLabel(text: "", fontSize: 16, fontStyle: .regular)
    private let tempLabel = UILabel.setBlackLabel(text: "", fontSize: 18, fontStyle: .regular)
    private let precipitationsImageView = UIImageView.setImage("rainIcon")

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
        backgroundColor = .specialLightBlue
        layer.cornerRadius = 5
        clipsToBounds = true

        [
         dateLabel,
         humidLabel,
         descriptionWeatherLabel,
         tempLabel,
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
            dateLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            dateLabel.trailingAnchor.constraint(equalTo: humidLabel.trailingAnchor, constant: 0),
            
            precipitationsImageView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: -3),
            precipitationsImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            precipitationsImageView.heightAnchor.constraint(equalToConstant: 30),
            precipitationsImageView.widthAnchor.constraint(equalToConstant: 30),
            precipitationsImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -3),

            humidLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 0),
            humidLabel.leadingAnchor.constraint(equalTo: precipitationsImageView.trailingAnchor, constant: 5),
            humidLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -7),

            tempLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
            tempLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0),

            descriptionWeatherLabel.leadingAnchor.constraint(equalTo: humidLabel.trailingAnchor, constant: 15),
            descriptionWeatherLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0),
//            descriptionWeatherLabel.trailingAnchor.constraint(equalTo: tempLabel.leadingAnchor, constant: -20),
        ])
    }
}
