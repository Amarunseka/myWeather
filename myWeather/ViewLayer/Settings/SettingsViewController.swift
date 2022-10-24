//
//  SettingsViewController.swift
//  myWeather
//
//  Created by Миша on 04.08.2022.
//

import UIKit

class SettingsViewController: UIViewController {
  
    // MARK: - Initial properties
    private let viewModel: SettingsViewModel
    private let titleLabel = UILabel.setBlackLabel(text: "Settings", fontSize: 18, fontStyle: .regular)
    private lazy var settingsView = SettingsMainView(viewModel: viewModel)

    private let backgroundImage: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(named: "settingsBackGround")
        imageView.image = image
        return imageView
    }()

    // MARK: - Life cycle
    init(viewModel: SettingsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setConstraints()
    }

    // MARK: - Private methods
    private func setupView(){
        self.title = "Editing"
        view.addSubview(backgroundImage)
        backgroundImage.frame = view.frame
        titleLabel.textAlignment = .center

        [titleLabel,
         settingsView].forEach{
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }

    // MARK: - Public methods
}
// MARK: - Set constraints
extension SettingsViewController {
    private func setConstraints(){
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            settingsView.heightAnchor.constraint(equalToConstant: view.frame.size.height / 2.5),
            settingsView.widthAnchor.constraint(equalToConstant: view.frame.size.width - 40),
            settingsView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0),
            settingsView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),

        ])
    }
}
