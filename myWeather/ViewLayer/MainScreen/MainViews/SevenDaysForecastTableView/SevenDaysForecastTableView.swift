//
//  SevenDaysForecastTableView.swift
//  myWeather
//
//  Created by Миша on 04.08.2022.
//

import UIKit

class SevenDaysForecastTableView: UITableView {
    // MARK: - Initial properties
    var didSelectRow: ((IndexPath)->())?
    var days = [Forecast]()
    private let sizes = SizesStorage.self

    // MARK: - Life cycle
    init() {
        super.init(frame: .zero, style: .plain)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private methods
    private func setupView(){
        self.backgroundColor = nil
        self.register(SevenDaysForecastTableViewCell.self, forCellReuseIdentifier: String(describing: SevenDaysForecastTableViewCell.self))
        self.delegate = self
        self.dataSource = self
        self.separatorStyle = .none
    }

    // MARK: - Public methods

}

// MARK: - Set constraints
extension SevenDaysForecastTableView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        days.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.dequeueReusableCell(withIdentifier: String(describing: SevenDaysForecastTableViewCell.self), for: indexPath) as? SevenDaysForecastTableViewCell else {return UITableViewCell()}
        cell.accessoryType = .disclosureIndicator
        cell.tintColor = UIColor.specialDarkBlue
        let image = UIImage(named:"sideArrow")?.withRenderingMode(.alwaysTemplate)

        let checkmark  = UIImageView(frame:CGRect(x:0, y:0, width:(image?.size.width)!, height:(image?.size.height)!));
        checkmark.image = image
        checkmark.backgroundColor = .specialLightBlue
        cell.accessoryView = checkmark

        cell.data = days[indexPath.section]
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        UIView(frame: .zero)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return sizes.cellSizes.sevenDaysTW
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        10
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.deselectRow(at: indexPath, animated: false)
        guard let didSelectRow = self.didSelectRow else {return}
        didSelectRow(indexPath)
    }
}
