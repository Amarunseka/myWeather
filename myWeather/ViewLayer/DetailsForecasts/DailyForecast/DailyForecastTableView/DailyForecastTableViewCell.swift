//
//  DailyForecastTableViewCell.swift
//  myWeather
//
//  Created by Миша on 05.08.2022.
//

import UIKit

class DailyForecastTableViewCell: UITableViewCell {
    
    // MARK: - Initial properties
    var data: Hour? {
        didSet {
            guard let data = data else {return}
            let date = data.hourTs.toDate()

            dateLabel.text = date.toString(type: .shortDate)
            //ЕСЛИ ВРЕМЯ ВЕЧЕРА ПОМЕНЯТЬ ИКОНКУ НА НОЧНУЮ
            
            timeLabel.text = date.toString(type: .time)
            
            let temp = Converter.convertDegreeScale(data.temp)
            let feelsLike = Converter.convertDegreeScale(data.feelsLike)
            tempLabel.text = "\(temp)˚"
            feelsLikeView.nameLabel.text = "Mostly \(temp)˚ - Feels like \(feelsLike)˚"
            feelsLikeView.nameLabel.setIconWithSize(text: "Mostly \(temp)˚ - Feels like \(feelsLike)˚",
                                                    icon: UIImage(named: "crescentIcon"),
                                                    width: sizes.iconSizes.middle,
                                                    height: sizes.iconSizes.middle)
            
            let wind = Converter.convertWindSpeed(data.windSpeed)
            windView.descriptionLabel?.text = "\(wind) (\(data.windDir.uppercased()))"
            
            // тут нет входящих данных нужно что-то придумать
//            precipitationsView.descriptionLabel?.text = "\(data.precStrength * 100)%"
            cloudyView.descriptionLabel?.text = "\(Int(data.cloudness * 100))%"
        }
    }
    
    private let sizes = SizesStorage.self

    private lazy var dateLabel = UILabel.setBlackLabel(text: "", fontSize: sizes.fontSizes.bigFontSize, fontStyle: .medium)
    private lazy var timeLabel = UILabel.setColorLabel(text: "", fontSize: sizes.fontSizes.smallFontSize, fontStyle: .regular, fontColor: .systemGray)
    private lazy var tempLabel = UILabel.setBlackLabel(text: "", fontSize: sizes.fontSizes.bigFontSize, fontStyle: .medium)
    
    private let feelsLikeView = DailyForecastDetailsView(icon: "crescentIcon", name: "", description: nil)
    private let windView = DailyForecastDetailsView(icon: "windIcon", name: "Wind", description: "")
    private let precipitationsView = DailyForecastDetailsView(icon: "humidityIcon", name: "Precipitations", description: "")
    private let cloudyView = DailyForecastDetailsView(icon: "cloudsIcon", name: "Cloudiness", description: "")



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
        contentView.backgroundColor = .specialLightBlue
        [dateLabel,
         timeLabel,
         tempLabel,
         feelsLikeView,
         windView,
         precipitationsView,
         cloudyView
        ].forEach{
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
    }


    // MARK: - Public methods



}

// MARK: - Set constraints
extension DailyForecastTableViewCell {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),

            timeLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: sizes.standartSpacingSizes.sideSpacing - 6),
            timeLabel.leadingAnchor.constraint(equalTo: dateLabel.leadingAnchor, constant: 0),

            tempLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 20),
            tempLabel.centerXAnchor.constraint(equalTo: timeLabel.centerXAnchor, constant: 0),

            feelsLikeView.topAnchor.constraint(equalTo: timeLabel.topAnchor, constant: 0),
            feelsLikeView.leadingAnchor.constraint(equalTo: timeLabel.trailingAnchor, constant: 15),
            feelsLikeView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),

            windView.topAnchor.constraint(equalTo: feelsLikeView.bottomAnchor, constant: 10),
            windView.leadingAnchor.constraint(equalTo: feelsLikeView.leadingAnchor, constant: 0),
            windView.trailingAnchor.constraint(equalTo: feelsLikeView.trailingAnchor, constant: 0),

            precipitationsView.topAnchor.constraint(equalTo: windView.bottomAnchor, constant: 10),
            precipitationsView.leadingAnchor.constraint(equalTo: feelsLikeView.leadingAnchor, constant: 0),
            precipitationsView.trailingAnchor.constraint(equalTo: feelsLikeView.trailingAnchor, constant: 0),

            cloudyView.topAnchor.constraint(equalTo: precipitationsView.bottomAnchor, constant: 10),
            cloudyView.leadingAnchor.constraint(equalTo: feelsLikeView.leadingAnchor, constant: 0),
            cloudyView.trailingAnchor.constraint(equalTo: feelsLikeView.trailingAnchor, constant: 0),
        ])
    }
}

