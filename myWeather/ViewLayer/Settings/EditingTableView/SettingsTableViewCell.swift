//
//  SettingsTableViewCell.swift
//  myWeather
//
//  Created by Миша on 07.08.2022.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {
    // MARK: - Initial properties
    var data: SettingsViewModel? {
        didSet {
            guard let setting = data else {return}
            nameLabel.text = setting.settingName
            stateOnTitle = setting.stateOnTitle
            stateOffTitle = setting.stateOffTitle
            setupSegmentedControl()
        }
    }
    
    var sendSegmentedState: ((Int)->())?
    
    private let nameLabel = UILabel.setColorLabel(text: "__", fontSize: 18, fontStyle: .regular, fontColor: .systemGray)
    private var stateOnTitle = "__"
    private var stateOffTitle = "__"
    lazy var segmentedControl = UISegmentedControl()   
    
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
        segmentedControl.addTarget(self, action: #selector(segmentedChange), for: .valueChanged)
        self.segmentedControl = segmentedControl
        [
            self.segmentedControl
        ].forEach{
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
    }
    
    @objc
    private func segmentedChange(){
        guard let sendSegmentedState = sendSegmentedState else {return}
        print(segmentedControl.selectedSegmentIndex)
        sendSegmentedState(segmentedControl.selectedSegmentIndex)
    }
}


// MARK: - Public methods



// MARK: - Set constraints
extension SettingsTableViewCell {
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
