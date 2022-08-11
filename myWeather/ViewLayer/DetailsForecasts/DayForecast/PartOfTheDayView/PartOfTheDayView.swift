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
            temp.text = "\(data.tempAvg ?? 0)˚"
            prescriptionsLabel.text = "\(data.condition)"
            print(data.condition)
            
            let icon = WeatherConditionIcons.init(iconName: data.condition)
            prescriptionsImageView.image = icon.icon
            
            let array = [
                ModelTableView(name: .feelsLike, condition: "\(data.feelsLike)˚"),
                ModelTableView(name: .wind, condition: "\(data.windSpeed) m/s (\(data.windDir.uppercased()))"),
                ModelTableView(name: .uvIndex, condition: "4 (MIDL)"),
                ModelTableView(name: .rain, condition: "\(data.precStrength)%"),
                ModelTableView(name: .cloudiness, condition: "\(Int(data.cloudness))"),
            ]
            tableView.data = array
            tableView.reloadData()
        }
    }

    private let partName: UILabel
    private let dataForTableView = [ModelTableView]()
    private let temp = UILabel.setBlackLabel(text: "__˚", fontSize: 30, fontStyle: .regular)
    private let prescriptionsLabel = UILabel.setBlackLabel(text: "____", fontSize: 14, fontStyle: .regular)
    private let prescriptionsImageView = UIImageView.setImage("sunIcon")
    private let tableView = PartOfTheDayTableView()
    
    // MARK: - Life cycle
    init(partName: String){
        self.partName = UILabel.setBlackLabel(text: partName, fontSize: 16, fontStyle: .medium)

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
        
        [partName,
         temp,
         prescriptionsLabel,
         prescriptionsImageView,
         tableView
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview($0)
        }
    }

    
    private func setFrames(){
        let size = temp.frame.size.height
        prescriptionsImageView.frame.size = CGSize(width: size, height: size)
    }

    // MARK: - Public methods

}

// MARK: - Set constraints
extension PartOfTheDayView {
    private func setConstraints(){
        NSLayoutConstraint.activate([
            partName.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            partName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),

            temp.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            temp.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0),
            
            prescriptionsImageView.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            prescriptionsImageView.trailingAnchor.constraint(equalTo: temp.leadingAnchor, constant: -25),

            prescriptionsLabel.topAnchor.constraint(equalTo: temp.bottomAnchor, constant: 10),
            prescriptionsLabel.centerXAnchor.constraint(equalTo: temp.leadingAnchor, constant: 0),
            
            tableView.topAnchor.constraint(equalTo: prescriptionsLabel.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
        ])
    }
}
