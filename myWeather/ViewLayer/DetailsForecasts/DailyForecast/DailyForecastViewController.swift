//
//  DailyForecastViewController.swift
//  myWeather
//
//  Created by Миша on 05.08.2022.
//

import UIKit

class DailyForecastViewController: DetailsForecastCommonViewController {
    // MARK: - Initial properties
    private let weatherData: [Hour]
    private let regionName: String
    private lazy var tableView = DailyForecastTableView(weatherData: weatherData)

    // MARK: - Life cycle
    init(regionName: String, weatherData: [Hour]) {
        self.regionName = regionName
        self.weatherData = weatherData
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setConstraints()
    }
    
    // MARK: - Private methods
    private func setupView(){
        view.backgroundColor = .white
        titleLabel.text = regionName
        [tableView
        ].forEach{
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
    }
    
    // MARK: - Public methods
}

// MARK: - Set constraints
extension DailyForecastViewController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }
}
