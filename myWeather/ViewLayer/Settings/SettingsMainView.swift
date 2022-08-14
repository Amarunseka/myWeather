//
//  SettingsMainView.swift
//  myWeather
//
//  Created by Миша on 07.08.2022.
//

import UIKit

enum SettingsNames: String {
    case name = "setting"
    case index = "index"
    case state = "state"
}

class SettingsMainView: UIView {
   
    // MARK: - Initial properties
    private let settingsLabel = UILabel.setBlackLabel(text: "Settings", fontSize: 18, fontStyle: .medium)
    private let tableView = SettingsTableView()
    private lazy var saveButton = UIButton.setButton(title: "SAVE SETTINGS", color: .specialOrange, fontSize: 18)
    private var settings = UserDefaultsManager.shared.settings.first?.value


    // MARK: - Life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setConstraints()
        getNotification()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    // MARK: - Private methods
    private func setupView() {
        backgroundColor = .specialLightBlue
        layer.cornerRadius = 10
        saveButton.addTarget(self, action: #selector(didSaveButtonTap), for: .touchUpInside)
        
        [settingsLabel,
         tableView,
         saveButton
        ].forEach{
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
    }
    
    private func getNotification(){
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(changeSettingState),
                                               name: Notification.Name("settingsChange"),
                                               object: nil)
    }
    
    @objc
    private func changeSettingState(_ notification: NSNotification){
        guard let data = notification.userInfo?["setting"] as? [String: Int],
              let state = data["state"],
              var setting = settings else {return}

        switch data["index"] {
        case 0:
            setting.tempMode = state
        case 1:
            setting.windSpeedMode = state
        case 2:
            setting.timeFormatMode = state
        case 3:
            setting.sentNotifications = state
        default:
            print("Element not found")
        }
        self.settings = setting
    }
    
    @objc
    private func didSaveButtonTap(){
        guard let data = settings else {return}
        let userDefaults = UserDefaultsManager.shared
        userDefaults.saveSettings(data)
    }


    // MARK: - Public methods

}

// MARK: - Set constraints
extension SettingsMainView {
    private func setConstraints(){
        NSLayoutConstraint.activate([
            settingsLabel.topAnchor.constraint(equalTo: topAnchor, constant: 30),
            settingsLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            
            tableView.topAnchor.constraint(equalTo: settingsLabel.bottomAnchor, constant: 5),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            
            saveButton.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 40),
            saveButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 45),
            saveButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -45),
            saveButton.heightAnchor.constraint(equalToConstant: 40),
            saveButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -30)
        ])
    }
}


