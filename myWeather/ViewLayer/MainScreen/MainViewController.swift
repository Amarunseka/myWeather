//
//  MainViewController.swift
//  myWeather
//
//  Created by Миша on 03.08.2022.
//

import UIKit

class MainViewController: UIViewController {

    // MARK: - Initial properties
    let viewModel: MainViewModel
    let sizes = SizesStorage.self
    
    private lazy var detailFor24HoursButton: UIButton = {
        let button = UIButton(type: .system)
        let text = "Details for 24 hours"
        let attributesString = NSMutableAttributedString(string: text)
        attributesString.addAttributes([NSAttributedString.Key.underlineStyle : NSUnderlineStyle.single.rawValue],
                                       range: NSRange(location: 0, length: text.count))
        button.setAttributedTitle(attributesString, for: .normal)
        button.tintColor = .black
        button.titleLabel?.textAlignment = .right
        button.titleLabel?.font = .rubik(size: sizes.fontSizes.titleFontSize, style: .regular)
        button.addTarget(self, action: #selector(didDetailButtonTapp), for: .touchUpInside)
        return button
    }()
    
    private let currentWeatherView = CurrentWeatherView()
    private lazy var hoursForecastCollectionView = HoursForecastCollectionView()
    private lazy var dailyForecastLabel = UILabel.setBlackLabel(text: "Daily forecast", fontSize: sizes.fontSizes.titleFontSize, fontStyle: .medium)
    private let sevenDaysForecastTableView = SevenDaysForecastTableView()


    // MARK: - Life cycle
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchWeather(viewController: self) { result in
            if result {
                guard let weatherData = WeatherData.weatherData else {return}
                DispatchQueue.main.async {
                    self.setParametersCurrenWeatherView(data: weatherData)
                    self.setParametersHoursForecastCollectionView(data: weatherData.forecasts[0].hours)
                    self.setParametersSevenDaysForecastTableView(data: weatherData.forecasts)
                }
            }
        }
        setupView()
        setConstraints()
    }
    
    
    // MARK: - Private methods
    private func setupView() {
        self.view.backgroundColor = .white
        
        [currentWeatherView,
         detailFor24HoursButton,
         hoursForecastCollectionView,
         dailyForecastLabel,
         sevenDaysForecastTableView,
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview($0)
        }
        
        sevenDaysForecastTableView.didSelectRow = { [weak self] indexPath in
            guard let self = self else {return}
            self.goToDayForecast(indexPath: indexPath)
        }
    }

    @objc
    private func didDetailButtonTapp(){
        viewModel.goToDetailVC(navigation: self)
    }
    
    private func goToDayForecast(indexPath: IndexPath) {
        viewModel.goToDayForecast(navigation: self)
    }

    private func setParametersCurrenWeatherView(data:WeatherModel) {
        currentWeatherView.data = data
    }
    
    private func setParametersHoursForecastCollectionView(data: [Hour]) {
        self.hoursForecastCollectionView.hoursForecasts = data
        self.hoursForecastCollectionView.reloadData()
        self.hoursForecastCollectionView.selectToCurrentItem()
    }
    
    private func setParametersSevenDaysForecastTableView(data: [Forecast]) {
        self.sevenDaysForecastTableView.days = data
        self.sevenDaysForecastTableView.reloadData()
    }
}

// MARK: - Set constraints
extension MainViewController {
    private func setConstraints(){

        NSLayoutConstraint.activate([
            currentWeatherView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            currentWeatherView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            currentWeatherView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            currentWeatherView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 1.95),
            
            detailFor24HoursButton.topAnchor.constraint(equalTo: currentWeatherView.bottomAnchor, constant: 25),
            detailFor24HoursButton.trailingAnchor.constraint(equalTo: currentWeatherView.trailingAnchor, constant: 0),
            
            hoursForecastCollectionView.topAnchor.constraint(equalTo: detailFor24HoursButton.bottomAnchor, constant: 10),
            hoursForecastCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            hoursForecastCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            hoursForecastCollectionView.heightAnchor.constraint(equalToConstant: sizes.cellSizes.hoursCW.1),
            
            dailyForecastLabel.topAnchor.constraint(equalTo: hoursForecastCollectionView.bottomAnchor, constant: 20),
            dailyForecastLabel.leadingAnchor.constraint(equalTo: currentWeatherView.leadingAnchor, constant: 10),
            
            sevenDaysForecastTableView.topAnchor.constraint(equalTo: dailyForecastLabel.bottomAnchor, constant: 0),
            sevenDaysForecastTableView.leadingAnchor.constraint(equalTo: currentWeatherView.leadingAnchor, constant: 0),
            sevenDaysForecastTableView.trailingAnchor.constraint(equalTo: currentWeatherView.trailingAnchor, constant: 0),
            sevenDaysForecastTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
        ])
    }
}


