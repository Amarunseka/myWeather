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
            
            /// Current temp
            let min = Converter.convertDegreeScale(data.forecasts[0].parts.night.tempMin ?? 00)
            let max = Converter.convertDegreeScale(data.forecasts[0].parts.day.tempMax ?? 00)
            minMaxTempLabel.text = "\(min)˚/\(max)˚"

            let temp = Converter.convertDegreeScale(data.fact.temp)
            temp < 10 && temp > -1
            ? (currentTempLabel.text = " \(temp)˚")
            : (currentTempLabel.text = "\(temp)˚")
            // здесь можно пойти дальше и сделать при отрицательных температурах, чтобы лучше отображалось но это уже я думаю не принципиально
            
            conditionLabel.text = data.fact.condition

            /// Sunrise & Sunset
            sunriseTimeLabel.text = data.forecasts[0].sunrise
            sunsetTimeLabel.text = data.forecasts[0].sunset

            /// Precipitation
            let icon = WeatherConditionIcons(iconName: data.fact.condition).icon
            precipitationConditionLabel.setIcon(text: "\(data.fact.cloudness)", icon: icon)
            
            let windSpeed = Converter.convertWindSpeed(data.fact.windSpeed)
            windConditionLabel.setIcon(text: "\(windSpeed)", icon: UIImage.windIcon)

            humidityConditionLabel.setIcon(text: "\(data.fact.humidity)%", icon: UIImage.humidityIcon)
            
            /// Current date
            currentTimeAndDateLabel.text = data.now.toDate().toString(type: .fullDate)

        }
    }
    
    private let fontSizes = SizesStorage.fontSizes
    private let selfSpacings = SizesStorage.currentWeatherViewSpacings
    private let standartSpacings = SizesStorage.standartSpacingSizes
    
    /// Ellipse
    private let sunEllipseImageView = UIImageView.setImage("sunEllipse")
    
    /// Sunrise
    private let sunriseImageView = UIImageView.setImage("sunriseIcon")
    private let arrowUpImageView = UIImageView.setImage("yellowArrowUp")
    private lazy var sunriseTimeLabel = UILabel.setWhiteLabel(text: "__:__", fontSize: fontSizes.standartFontSize, fontStyle: .regular)
    private lazy var sunriseStackView = UIStackView.set(subViews: [sunriseImageView, arrowUpImageView, sunriseTimeLabel], axis: .vertical, spacing: selfSpacings.betweenSunriseSW)

    
    /// Sunset
    private let sunsetImageView = UIImageView.setImage("sunriseIcon")
    private let arrowDownImageView = UIImageView.setImage("yellowArrowDown")
    private lazy var sunsetTimeLabel = UILabel.setWhiteLabel(text: "__:__", fontSize: fontSizes.standartFontSize, fontStyle: .regular)
    private lazy var sunsetStackView = UIStackView.set(subViews: [arrowDownImageView, sunsetImageView, sunsetTimeLabel], axis: .vertical, spacing: selfSpacings.betweenSunriseSW)


    /// Curent temp properties
    private lazy var minMaxTempLabel = UILabel.setWhiteLabel(text: "__˚__˚", fontSize: fontSizes.bigFontSize, fontStyle: .regular)
    private lazy var currentTempLabel = UILabel.setWhiteLabel(text: "__˚", fontSize: fontSizes.enormousFontSize, fontStyle: .medium)
    private lazy var conditionLabel = UILabel.setWhiteLabel(text: "...", fontSize: fontSizes.standartFontSize, fontStyle: .regular)
    private lazy var currentTempStackView = UIStackView.set(subViews: [minMaxTempLabel, currentTempLabel,conditionLabel], axis: .vertical, spacing: selfSpacings.betweenCurrentTempSW)

    
    /// Precipitation properties
    private lazy var precipitationConditionLabel: UILabel = {
        let label = UILabel.setWhiteLabel(text: "_._", fontSize: fontSizes.standartFontSize, fontStyle: .regular)
        label.setIcon(text: "_._", icon: UIImage.cloudsAndSunIcon)
        return label
    }()
    private lazy var windConditionLabel: UILabel = {
        let label = UILabel.setWhiteLabel(text: "__ m/s", fontSize: fontSizes.standartFontSize, fontStyle: .regular)
        label.setIcon(text: "_._", icon: UIImage.windIcon)
        return label
    }()
    private lazy var humidityConditionLabel: UILabel = {
        let label = UILabel.setWhiteLabel(text: "__%", fontSize: fontSizes.standartFontSize, fontStyle: .regular)
        label.setIcon(text: "__%", icon: UIImage.humidityIcon)
        return label
    }()
    private lazy var precipitationStackView = UIStackView.set(subViews: [precipitationConditionLabel, windConditionLabel, humidityConditionLabel], axis: .horizontal, spacing: selfSpacings.betweenPrecipitationSW)

    /// Curent date
    private lazy var currentTimeAndDateLabel = UILabel.setColorLabel(text: "__:__, ...", fontSize: fontSizes.bigFontSize, fontStyle: .regular, fontColor: .yellow)

    
    // MARK: - Life cycle
    init(){        
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        setConstraints()
    }

    // MARK: - Private methods
    private func setupView(){
        backgroundColor = .specialDarkBlue
        layer.cornerRadius = 10
        sunEllipseImageView.contentMode = .scaleToFill
        
        currentTempStackView.alignment = .center
        
        [sunEllipseImageView,
         sunriseStackView,
         sunsetStackView,
         currentTempStackView,
         precipitationStackView,
         currentTimeAndDateLabel
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview($0)
        }
    }

    // MARK: - Public methods

}

// MARK: - Set constraints
extension CurrentWeatherView {
    private func setConstraints(){
        
        NSLayoutConstraint.activate([
            sunriseStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: standartSpacings.sideSpacing),
            sunriseStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -standartSpacings.sideSpacing),

            sunsetStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -standartSpacings.sideSpacing),
            sunsetStackView.bottomAnchor.constraint(equalTo: sunriseStackView.bottomAnchor, constant: 0),

            sunEllipseImageView.topAnchor.constraint(equalTo: topAnchor, constant: standartSpacings.sideSpacing),
            sunEllipseImageView.leadingAnchor.constraint(equalTo: sunriseStackView.centerXAnchor, constant: -2),
            sunEllipseImageView.trailingAnchor.constraint(equalTo: sunsetStackView.centerXAnchor, constant: 2),
            sunEllipseImageView.bottomAnchor.constraint(equalTo: sunriseStackView.topAnchor, constant: -selfSpacings.betweenSunriseSW),

            currentTempStackView.bottomAnchor.constraint(equalTo: centerYAnchor, constant: standartSpacings.sideSpacing),
            currentTempStackView.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0),

            precipitationStackView.topAnchor.constraint(equalTo: currentTempStackView.bottomAnchor, constant: standartSpacings.sideSpacing),
            precipitationStackView.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0),
            
            currentTimeAndDateLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -selfSpacings.currentDateBottom),
            currentTimeAndDateLabel.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0)
        ])
    }
}
