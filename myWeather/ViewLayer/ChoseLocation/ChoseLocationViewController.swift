//
//  ChoseLocationViewController.swift
//  myWeather
//
//  Created by Миша on 04.08.2022.
//

import UIKit

class ChoseLocationViewController: UIViewController {
  
    // MARK: - Initial properties
    private let viewModel: ChoseLocationViewModel
    private let titleLabel = UILabel.setBlackLabel(text: "Chose location", fontSize: 18, fontStyle: .regular)
    private lazy var addNewLocationAlert = AddNewLocationAlert(vc: self)

    private lazy var addLocationButton: UIButton = {
        let button = UIButton(type: .system)
        button.setBackgroundImage(UIImage(systemName: "plus"), for: .normal)
        button.tintColor = .specialDarkBlue
        button.addTarget(self, action: #selector(didTapAddLocationButton), for: .touchUpInside)
        return button
    }()

    // MARK: - Life cycle
    init(viewModel: ChoseLocationViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAddNewLocationAlert()
        setupView()
        setConstraints()
    }

    // MARK: - Private methods
    private func setupView(){
        view.backgroundColor = .white
        titleLabel.textAlignment = .center
        
        [addLocationButton,
         titleLabel
        ].forEach{
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
    }
    
    private func setupAddNewLocationAlert(){
        view.addSubview(addNewLocationAlert)

        addNewLocationAlert.outputText = { [weak self ] city in
            guard let self = self else {return}
            self.viewModel.getCityInfo(city: city)
        }
    }
    
    @objc
    private func didTapAddLocationButton(){
        addNewLocationAlert.presentAlert()
    }

    // MARK: - Public methods
}
// MARK: - Set constraints
extension ChoseLocationViewController{
    private func setConstraints(){
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            addLocationButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            addLocationButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0),
            addLocationButton.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -view.frame.size.width/1.5),
            addLocationButton.heightAnchor.constraint(equalTo: addLocationButton.widthAnchor)
        ])
    }
}
