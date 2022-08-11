//
//  DetailsForecastCommonViewController.swift
//  myWeather
//
//  Created by Миша on 06.08.2022.
//

import UIKit


class DetailsForecastCommonViewController: UIViewController {
    // MARK: - Initial properties
    let titleLabel = UILabel.setBlackLabel(text: "Moscow, Russia", fontSize: 18, fontStyle: .regular)
    
    lazy var goBackButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(systemName: "arrow.backward")
        button.setImage(image, for: .normal)
        button.setTitle("  Back", for: .normal)
        button.tintColor = .black
        button.titleLabel?.font = .rubik(size: 16, style: .regular)
        button.setTitleColor(.systemGray, for: .normal)
        button.semanticContentAttribute = .forceLeftToRight
        button.addTarget(self, action: #selector(didTapGoBackButton), for: .touchUpInside)
        return button
    }()


    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setConstraints()
    }
    
    // MARK: - Private methods
    private func setupView(){
        view.backgroundColor = .white
        [titleLabel,
         goBackButton,
        ].forEach{
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
    }
    
    @objc
    private func didTapGoBackButton(){
        dismiss(animated: true)
    }

    // MARK: - Public methods
}

// MARK: - Set constraints
extension DetailsForecastCommonViewController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            goBackButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            goBackButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),

            titleLabel.topAnchor.constraint(equalTo: goBackButton.topAnchor, constant: 40),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0)
        ])
    }
}
