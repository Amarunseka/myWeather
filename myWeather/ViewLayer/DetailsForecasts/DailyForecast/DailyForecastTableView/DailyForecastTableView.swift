//
//  DailyForecastTableView.swift
//  myWeather
//
//  Created by Миша on 05.08.2022.
//

import UIKit

class DailyForecastTableView: UITableView {

    // MARK: - Initial properties
    private let weatherData: [Hour]

    // MARK: - Life cycle
    init(weatherData: [Hour]){
        self.weatherData = weatherData
        super.init(frame: .zero, style: .plain)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private methods
    private func setupView(){
        register(DailyForecastTableViewCell.self, forCellReuseIdentifier: String(describing: DailyForecastTableViewCell.self))
        self.delegate = self
        self.dataSource = self
        backgroundColor = nil
        self.separatorColor = .specialDarkBlue
    }

    // MARK: - Public methods
}


// MARK: - UITableViewDelegate, UITableViewDataSource
extension DailyForecastTableView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: DailyForecastTableViewCell.self),
                                                       for: indexPath) as? DailyForecastTableViewCell else {return UITableViewCell()}
        cell.data = weatherData[(indexPath.row * 3)]
        cell.separatorInset.right = cell.separatorInset.left
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        150
    }
}
