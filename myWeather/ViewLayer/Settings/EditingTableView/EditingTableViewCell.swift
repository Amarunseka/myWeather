//
//  EditingTableViewCell.swift
//  myWeather
//
//  Created by Миша on 07.08.2022.
//

import UIKit

class EditingTableViewCell: UITableViewCell {
    // MARK: - Initial properties
    var setting: EditingSettingsModel? {
        didSet {
            guard let setting = setting else {return}
            nameLabel.text = setting.settingName
            stateOnTitle = setting.stateOnTitle
            stateOffTitle = setting.stateOffTitle
            setupSegmentedControl()
        }
    }
    
    private let nameLabel = UILabel.setColorLabel(text: "", fontSize: 18, fontStyle: .regular, fontColor: .systemGray)
    private var stateOnTitle = "On"
    private var stateOffTitle = "Off"
    private lazy var segmentedControl = UISegmentedControl()
   
    
    // MARK: - Life cycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setConstraints()
    }
    
    // MARK: - Private methods
    private func setupView(){
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        
        [nameLabel,
        ].forEach{
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
    }
    
    private func setupSegmentedControl(){
        let segmentedControl = UISegmentedControl(items: [stateOnTitle, stateOffTitle])
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.backgroundColor = .specialPink
        segmentedControl.selectedSegmentTintColor = .specialDarkBlue
        segmentedControl.setTitleTextAttributes([.font: UIFont.rubik(size: 16, style: .regular) as Any,
                                                 .foregroundColor: UIColor.black], for: .normal)
        segmentedControl.setTitleTextAttributes([.font: UIFont.rubik(size: 16, style: .regular) as Any,
                                                 .foregroundColor: UIColor.white], for: .selected)
        
        self.segmentedControl = segmentedControl
        [
            self.segmentedControl
        ].forEach{
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
    }
}


// MARK: - Public methods



// MARK: - Set constraints
extension EditingTableViewCell {
    private func setConstraints(){

        NSLayoutConstraint.activate([
            nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            
            segmentedControl.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0),
            segmentedControl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            segmentedControl.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
}
