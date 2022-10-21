//
//  PartOfTheDayTableView.swift
//  myWeather
//
//  Created by Миша on 09.08.2022.
//

import UIKit

class PartOfTheDayTableView: UITableView {
    
    // MARK: - Initial properties
    var data = [ModelTableView]()
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
        self.register(PartOfTheDayTableViewCell.self, forCellReuseIdentifier: String(describing: PartOfTheDayTableViewCell.self))
        self.delegate = self
        self.dataSource = self
        self.separatorColor = .specialDarkBlue
        self.separatorInset.left = 0
    }
    
    // MARK: - Public methods
}

// MARK: - Set constraints
extension PartOfTheDayTableView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.dequeueReusableCell(withIdentifier: String(describing: PartOfTheDayTableViewCell.self), for: indexPath) as? PartOfTheDayTableViewCell else {return UITableViewCell()}
        cell.data = data[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        sizes.cellSizes.parts.1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.deselectRow(at: indexPath, animated: false)
    }
}
