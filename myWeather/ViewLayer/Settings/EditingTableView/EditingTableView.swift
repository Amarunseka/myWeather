//
//  EditingTableView.swift
//  myWeather
//
//  Created by Миша on 07.08.2022.
//

import UIKit

class EditingTableView: UITableView {
    
    // MARK: - Initial properties
    var didSelectRow: ((IndexPath)->())?

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
        self.register(EditingTableViewCell.self, forCellReuseIdentifier: String(describing: EditingTableViewCell.self))
        self.delegate = self
        self.dataSource = self
        self.separatorStyle = .none
    }


    // MARK: - Public methods



}

// MARK: - Set constraints
extension EditingTableView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        EditingSettingsModel.settings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.dequeueReusableCell(withIdentifier: String(describing: EditingTableViewCell.self), for: indexPath) as? EditingTableViewCell else {
            return UITableViewCell()}
        
        cell.setting = EditingSettingsModel.settings[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        50
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.deselectRow(at: indexPath, animated: false)
        guard let didSelectRow = self.didSelectRow else {return}
        didSelectRow(indexPath)
    }
}
