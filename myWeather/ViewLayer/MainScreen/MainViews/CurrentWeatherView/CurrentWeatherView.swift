//
//  CurrentWeatherView.swift
//  myWeather
//
//  Created by Миша on 03.08.2022.
//

import UIKit

class CurrentWeatherView: UIView {
    
    // MARK: - Initial properties
    var data: WeatherModel? {
        didSet{
            guard let data = data else {return}
            currentTimeAndDateLabel.text = data.now.toDate().toString(type: .fullDate)
            sunriseTimeLabel.text = data.forecasts[0].sunrise
            sunsetTimeLabel.text = data.forecasts[0].sunset
            
            let temp = Converter.convertDegreeScale(data.fact.temp)
            currentTempLabel.text = "\(temp)˚"
            
            conditionLabel.text = data.fact.condition
            precipitationConditionLabel.text = "\(data.fact.cloudness)"
            
            let windSpeed = Converter.convertWindSpeed(data.fact.windSpeed)
            windConditionLabel.text = windSpeed
            humidityConditionLabel.text = "\(data.fact.humidity)%"
            
            let min = Converter.convertDegreeScale(data.forecasts[0].parts.night.tempMin ?? 00)
            let max = Converter.convertDegreeScale(data.forecasts[0].parts.day.tempMax ?? 00)
            minMaxTempLabel.text = "\(min)˚/\(max)˚"
            
            let icon = WeatherConditionIcons(iconName: data.fact.condition)
            precipitationConditionImageView.image = icon.icon
        }
    }
    
    /// Icons
    private let sunEllipseImageView = UIImageView.setImage("sunEllipse")
    private let sunriseImageView = UIImageView.setImage("sunriseIcon")
    private let sunsetImageView = UIImageView.setImage("sunriseIcon")
    private let arrowUpImageView = UIImageView.setImage("yellowArrowUp")
    private let arrowDownImageView = UIImageView.setImage("yellowArrowDown")
    private let precipitationConditionImageView = UIImageView.setImage("cloudsAndSun")
    private let windConditionImageView = UIImageView.setImage("windIcon")
    private let humidityConditionImageView = UIImageView.setImage("humidityIcon")

    /// Labels
    private let sunriseTimeLabel = UILabel.setWhiteLabel(text: "__:__", fontSize: 14, fontStyle: .regular)
    private let sunsetTimeLabel = UILabel.setWhiteLabel(text: "__:__", fontSize: 14, fontStyle: .regular)
    private let minMaxTempLabel = UILabel.setWhiteLabel(text: "__˚__˚", fontSize: 16, fontStyle: .regular)
    private let currentTempLabel = UILabel.setWhiteLabel(text: "__˚", fontSize: 36, fontStyle: .medium)
    private let conditionLabel = UILabel.setWhiteLabel(text: "...", fontSize: 14, fontStyle: .regular)
    private let precipitationConditionLabel = UILabel.setWhiteLabel(text: "_._", fontSize: 14, fontStyle: .regular)
    private let windConditionLabel = UILabel.setWhiteLabel(text: "__ m/s", fontSize: 14, fontStyle: .regular)
    private let humidityConditionLabel = UILabel.setWhiteLabel(text: "__%", fontSize: 14, fontStyle: .regular)
    private let currentTimeAndDateLabel = UILabel.setColorLabel(text: "__:__, ...", fontSize: 16, fontStyle: .regular, fontColor: .yellow)

    // MARK: - Life cycle
    init(){        
        super.init(frame: .zero)
        setupView()
    }
    
    override func layoutSubviews() {
        setConstraints()
    }
    
    
    // MARK: - Private methods
    private func setupView(){
        backgroundColor = .specialDarkBlue
        layer.cornerRadius = 10
        sunEllipseImageView.contentMode = .scaleToFill

        
        [sunEllipseImageView,
         sunriseImageView,
         sunsetImageView,
         arrowUpImageView,
         arrowDownImageView,
         sunriseTimeLabel,
         sunsetTimeLabel,
         minMaxTempLabel,
         currentTempLabel,
         conditionLabel,
         precipitationConditionImageView,
         windConditionImageView,
         humidityConditionImageView,
         precipitationConditionLabel,
         windConditionLabel,
         humidityConditionLabel,
         currentTimeAndDateLabel
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview($0)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public methods

}

// MARK: - Set constraints
extension CurrentWeatherView {
    private func setConstraints(){
        NSLayoutConstraint.activate([
            sunEllipseImageView.topAnchor.constraint(equalTo: topAnchor, constant: 17),
            sunEllipseImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 31),
            sunEllipseImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -31),
            sunEllipseImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -62),
            
            
            arrowUpImageView.topAnchor.constraint(equalTo: sunEllipseImageView.bottomAnchor, constant: 3),
            arrowUpImageView.leadingAnchor.constraint(equalTo: sunEllipseImageView.leadingAnchor, constant: -2),
            arrowUpImageView.heightAnchor.constraint(equalToConstant: 7),
            arrowUpImageView.widthAnchor.constraint(equalToConstant: 7),

            sunriseImageView.topAnchor.constraint(equalTo: arrowUpImageView.bottomAnchor, constant: 1),
            sunriseImageView.centerXAnchor.constraint(equalTo: arrowUpImageView.centerXAnchor, constant: 0),
            sunriseImageView.heightAnchor.constraint(equalToConstant: 9),
            sunriseImageView.widthAnchor.constraint(equalToConstant: 17),

            sunriseTimeLabel.centerXAnchor.constraint(equalTo: sunriseImageView.centerXAnchor, constant: 0),
            sunriseTimeLabel.topAnchor.constraint(equalTo: sunriseImageView.bottomAnchor, constant: 4),


            sunsetImageView.topAnchor.constraint(equalTo: sunEllipseImageView.bottomAnchor, constant: 3),
            sunsetImageView.trailingAnchor.constraint(equalTo: sunEllipseImageView.trailingAnchor, constant: 7),
            sunsetImageView.heightAnchor.constraint(equalToConstant: 9),
            sunsetImageView.widthAnchor.constraint(equalToConstant: 17),

            arrowDownImageView.topAnchor.constraint(equalTo: sunsetImageView.bottomAnchor, constant: 1),
            arrowDownImageView.centerXAnchor.constraint(equalTo: sunsetImageView.centerXAnchor, constant: 0),
            arrowDownImageView.heightAnchor.constraint(equalToConstant: 7),
            arrowDownImageView.widthAnchor.constraint(equalToConstant: 7),
            
            sunsetTimeLabel.centerXAnchor.constraint(equalTo: arrowDownImageView.centerXAnchor, constant: 0),
            sunsetTimeLabel.topAnchor.constraint(equalTo: arrowDownImageView.bottomAnchor, constant: 4),
            
            
            minMaxTempLabel.topAnchor.constraint(equalTo: topAnchor, constant: 33),
            minMaxTempLabel.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0),

            currentTempLabel.topAnchor.constraint(equalTo: minMaxTempLabel.bottomAnchor, constant: 5),
            currentTempLabel.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0),

            conditionLabel.topAnchor.constraint(equalTo: currentTempLabel.bottomAnchor, constant: 5),
            conditionLabel.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0),

            conditionLabel.topAnchor.constraint(equalTo: currentTempLabel.bottomAnchor, constant: 5),
            conditionLabel.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0),
            
            
            windConditionLabel.topAnchor.constraint(equalTo: conditionLabel.bottomAnchor, constant: 15),
            windConditionLabel.leadingAnchor.constraint(equalTo: centerXAnchor, constant: 0),
            
            windConditionImageView.topAnchor.constraint(equalTo: windConditionLabel.topAnchor, constant: 0),
            windConditionImageView.trailingAnchor.constraint(equalTo: windConditionLabel.leadingAnchor, constant: -5),
            windConditionImageView.heightAnchor.constraint(equalToConstant: 20),
            windConditionImageView.widthAnchor.constraint(equalToConstant: 40),

            
            precipitationConditionLabel.topAnchor.constraint(equalTo: windConditionLabel.topAnchor, constant: 0),
            precipitationConditionLabel.trailingAnchor.constraint(equalTo: windConditionImageView.leadingAnchor, constant: -20),

            precipitationConditionImageView.topAnchor.constraint(equalTo: windConditionLabel.topAnchor, constant: 0),
            precipitationConditionImageView.trailingAnchor.constraint(equalTo: precipitationConditionLabel.leadingAnchor, constant: -2),
            precipitationConditionImageView.heightAnchor.constraint(equalToConstant: 20),
            precipitationConditionImageView.widthAnchor.constraint(equalToConstant: 30),


            humidityConditionImageView.centerYAnchor.constraint(equalTo: humidityConditionLabel.centerYAnchor, constant: 0),
            humidityConditionImageView.leadingAnchor.constraint(equalTo: windConditionLabel.trailingAnchor, constant: 20),
            humidityConditionImageView.heightAnchor.constraint(equalToConstant: 30),
            humidityConditionImageView.widthAnchor.constraint(equalToConstant: 40),

            humidityConditionLabel.topAnchor.constraint(equalTo: windConditionLabel.topAnchor, constant: 0),
            humidityConditionLabel.leadingAnchor.constraint(equalTo: humidityConditionImageView.trailingAnchor, constant: 2),

            
            currentTimeAndDateLabel.topAnchor.constraint(equalTo: windConditionLabel.bottomAnchor, constant: 25),
            currentTimeAndDateLabel.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0)
        ])
    }
}
