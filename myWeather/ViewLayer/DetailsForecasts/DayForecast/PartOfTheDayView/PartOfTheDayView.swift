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
            tempLabel.text = "\(temp)˚"
            
            prescriptionsLabel.text = "\(data.condition)"
            
            let icon = WeatherConditionIcons.init(iconName: data.condition)
            prescriptionsImageView.image = icon.icon
            
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

    private let dataForTableView = [ModelTableView]()
    private let partNameLabel: UILabel
    private let tempLabel = UILabel.setBlackLabel(text: "__˚", fontSize: 30, fontStyle: .regular)
    private let prescriptionsLabel = UILabel.setBlackLabel(text: "...", fontSize: 14, fontStyle: .regular)
    private let prescriptionsImageView = UIImageView.setImage("sunIcon")
    private let tableView = PartOfTheDayTableView()
    
    // MARK: - Life cycle
    init(partName: String){
        self.partNameLabel = UILabel.setBlackLabel(text: partName, fontSize: 16, fontStyle: .medium)
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
        backgroundColor = .specialLightBlue
        layer.cornerRadius = 10
        
        [partNameLabel,
         tempLabel,
         prescriptionsLabel,
         prescriptionsImageView,
         tableView
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview($0)
        }
    }

    
    private func setFrames(){
        let size = tempLabel.frame.size.height
        prescriptionsImageView.frame.size = CGSize(width: size, height: size)
    }

    // MARK: - Public methods

}

// MARK: - Set constraints
extension PartOfTheDayView {
    private func setConstraints(){
        NSLayoutConstraint.activate([
            partNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            partNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),

            tempLabel.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            tempLabel.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0),
            
            prescriptionsImageView.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            prescriptionsImageView.trailingAnchor.constraint(equalTo: tempLabel.leadingAnchor, constant: -25),

            prescriptionsLabel.topAnchor.constraint(equalTo: tempLabel.bottomAnchor, constant: 10),
            prescriptionsLabel.centerXAnchor.constraint(equalTo: tempLabel.leadingAnchor, constant: 0),
            
            tableView.topAnchor.constraint(equalTo: prescriptionsLabel.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
        ])
    }
}
