//
//  SettingsTableView.swift
//  myWeather
//
//  Created by Миша on 07.08.2022.
//

import UIKit

class SettingsTableView: UITableView {
    
    // MARK: - Initial properties
    private let settings = UserDefaultsManager.shared.settings
    private var userInfo = [String : [String:Int]]()
    
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
        self.register(SettingsTableViewCell.self, forCellReuseIdentifier: String(describing: SettingsTableViewCell.self))
        self.delegate = self
        self.dataSource = self
        self.separatorStyle = .none
    }
    
    private func sendNotification(index: Int, state: Int){
        userInfo = ["setting" : ["index" : index,
                                 "state" : state
                                ]]
        NotificationCenter.default.post(name: Notification.Name("settingsChange"), object: nil, userInfo: userInfo)
    }
    
    
    // MARK: - Public methods
}

// MARK: - Set constraints
extension SettingsTableView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        SettingsTableViewModel.settings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.dequeueReusableCell(withIdentifier: String(describing: SettingsTableViewCell.self), for: indexPath) as? SettingsTableViewCell else {
            return UITableViewCell()}
        
        cell.data = SettingsTableViewModel.settings[indexPath.row]
        switch indexPath.row {
        case 0:
            cell.segmentedControl.selectedSegmentIndex = settings.tempMode
        case 1:
            cell.segmentedControl.selectedSegmentIndex = settings.windSpeedMode
        case 2:
            cell.segmentedControl.selectedSegmentIndex = settings.timeFormatMode
        case 3:
            cell.segmentedControl.selectedSegmentIndex = settings.sentNotifications
        default:
            print("error")
        }
        
        cell.sendSegmentedState = { [weak self] state in
            self?.sendNotification(index: indexPath.row, state: state)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.deselectRow(at: indexPath, animated: false)
    }
}
