//
//  PartOfTheDayView.swift
//  myWeather
//
//  Created by Миша on 09.08.2022.
//

import UIKit

enum IconsForParts: String {
    case feelsLike = "Feels like"
    case wind = "Wind"
    case uvIndex = "UV Index"
    case rain = "Rain"
    case cloudiness = "Cloudiness"
    
    var icon: UIImage? {
        switch self {
        case .feelsLike:
            return UIImage.termSun
        case .wind:
            return UIImage.windIcon
        case .uvIndex:
            return UIImage.sunIcon
        case .rain:
            return UIImage.rainIcon
        case .cloudiness:
            return UIImage.cloudsIcon
        }
    }
}

struct ModelTableView {
    let name: IconsForParts
    let condition: String
}

class PartOfTheDayView: UIView {
    
    // MARK: - Initial properties
    var data: PartOfTheDay? {
        didSet{
            guard let data = data else {return}
            let temp = Converter.convertDegreeScale(data.tempAvg ?? 0)
            let icon = WeatherConditionIcons.init(iconName: data.condition)
            
            tempLabel.setIconWithSize(text: "\(temp)˚", icon: icon.icon, width: sizes.iconSizes.big, height: sizes.iconSizes.big)
            prescriptionsLabel.text = "\(data.condition)"
            
            let feelsLike = Converter.convertDegreeScale(data.feelsLike)
            let wind = Converter.convertWindSpeed(data.windSpeed)
            let uvIndex = Converter.convertUVIndex(data.uvIndex)
            let array = [
                ModelTableView(name: .feelsLike, condition: "\(feelsLike)˚"),
                ModelTableView(name: .wind, condition: "\(wind) (\(data.windDir.uppercased()))"),
                ModelTableView(name: .uvIndex, condition: "\(uvIndex)"),
//                ModelTableView(name: .rain, condition: "\(data.precStrength)%"),
                ModelTableView(name: .rain, condition: "%"),
                ModelTableView(name: .cloudiness, condition: "\(Int(data.cloudness))"),
            ]
            tableView.data = array
            tableView.reloadData()
        }
    }

    private let sizes = SizesStorage.self
    private let dataForTableView = [ModelTableView]()
    private let partNameLabel: UILabel
    
    private lazy var tempLabel: UILabel = {
        let label = UILabel.setBlackLabel(text: "__˚", fontSize: sizes.fontSizes.enormousFontSize , fontStyle: .regular)
        label.setIcon(text: "__˚", icon: UIImage.sunIcon)
        return label
    }()

    private lazy var prescriptionsLabel = UILabel.setBlackLabel(text: "...", fontSize: sizes.fontSizes.standartFontSize, fontStyle: .regular)
    private let tableView = PartOfTheDayTableView()
    
    // MARK: - Life cycle
    init(partName: String){
        self.partNameLabel = UILabel.setBlackLabel(text: partName, fontSize: sizes.fontSizes.bigFontSize, fontStyle: .medium)
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
        backgroundColor = .specialLightBlue
        layer.cornerRadius = 10
        
        [partNameLabel,
         tempLabel,
         prescriptionsLabel,
         tableView
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview($0)
        }
    }

    // MARK: - Public methods
}

// MARK: - Set constraints
extension PartOfTheDayView {
    private func setConstraints(){
        let topSpacing = sizes.standartSpacingSizes.sideSpacing - 5
        NSLayoutConstraint.activate([
            partNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: sizes.standartSpacingSizes.sideSpacing),
            partNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: topSpacing),

            tempLabel.topAnchor.constraint(equalTo: topAnchor, constant: topSpacing),
            tempLabel.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0),

            prescriptionsLabel.topAnchor.constraint(equalTo: tempLabel.bottomAnchor, constant: topSpacing),
            prescriptionsLabel.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0),
            
            tableView.topAnchor.constraint(equalTo: prescriptionsLabel.bottomAnchor, constant: sizes.standartSpacingSizes.sideSpacing),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
        ])
    }
}
