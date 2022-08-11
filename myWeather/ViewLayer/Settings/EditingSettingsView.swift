//
//  EditingSettingsView.swift
//  myWeather
//
//  Created by Миша on 07.08.2022.
//

import UIKit

class EditingSettingsView: UIView {
   
    // MARK: - Initial properties
    private let settingsLabel = UILabel.setBlackLabel(text: "Settings", fontSize: 18, fontStyle: .medium)
    private let tableView = EditingTableView()
    private lazy var saveButton = UIButton.setButton(title: "SAVE SETTINGS", color: .specialOrange, fontSize: 18)


    // MARK: - Life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setConstraints()
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
    
    @objc
    private func didSaveButtonTap(){
        print("didSaveButtonTap")
    }


    // MARK: - Public methods

}

// MARK: - Set constraints
extension EditingSettingsView {
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


