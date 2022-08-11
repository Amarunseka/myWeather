//
//  OnBoardingViewController.swift
//  myWeather
//
//  Created by Миша on 08.08.2022.
//

import UIKit

class OnBoardingViewController: UIViewController {
    
    
    // MARK: - Initial properties
    private let imageView = UIImageView.setImage("onBoardingImage")
    private let requestDescriptionLabel = UILabel.setWhiteLabel(text: "Do allow the Weather app to use your device's location", fontSize: 16, fontStyle: .medium)
    private let descriptionRequestPurposeLabel = UILabel.setWhiteLabel(text: "To get more accurate weather forecast while driving or traveling", fontSize: 16, fontStyle: .regular)
    private let changeChoseDescriptionLabel = UILabel.setWhiteLabel(text: "You can change your choice at any time in your app's menu", fontSize: 16, fontStyle: .regular)
    private let useAppLocationButton = UIButton.setButton(title: "use application's location", color: .specialOrange, fontSize: 16)
    private let addMyselfLocationButton = UIButton.setButton(title: "NO, I'LL ADD LOCATION BY MYSELF", color: .clear, fontSize: 16)

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupLabels()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setConstraints()
    }


    // MARK: - Private methods
    private func setupView(){
        view.backgroundColor = .specialDarkBlue
        useAppLocationButton.addTarget(self, action: #selector(didUseAppLocationButtonTap), for: .touchUpInside)
        addMyselfLocationButton.addTarget(self, action: #selector(didAddMyselfLocationButton), for: .touchUpInside)

        [imageView,
         requestDescriptionLabel,
         descriptionRequestPurposeLabel,
         changeChoseDescriptionLabel,
         useAppLocationButton,
         addMyselfLocationButton
        ].forEach{
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
    }
    
    private func setupLabels(){
        [requestDescriptionLabel,
         descriptionRequestPurposeLabel,
         changeChoseDescriptionLabel,
        ].forEach{
            $0.numberOfLines = 3
            $0.textAlignment = .center
        }
        
        addMyselfLocationButton.titleLabel?.textAlignment = .right
    }
    
    @objc
    private func didUseAppLocationButtonTap(){
        print("didUseAppLocationButtonTap")

    }
    
    @objc
    private func didAddMyselfLocationButton(){
        print("didAddMyselfLocationButton")
    }


    // MARK: - Public methods



}

// MARK: - Set constraints
extension OnBoardingViewController {
    private func setConstraints(){
        NSLayoutConstraint.activate([
            
            imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            imageView.heightAnchor.constraint(equalToConstant: 200),
            imageView.widthAnchor.constraint(equalToConstant: 200),
            
            requestDescriptionLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 100),
            requestDescriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            requestDescriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            descriptionRequestPurposeLabel.topAnchor.constraint(equalTo: requestDescriptionLabel.bottomAnchor, constant: 30),
            descriptionRequestPurposeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descriptionRequestPurposeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            changeChoseDescriptionLabel.topAnchor.constraint(equalTo: descriptionRequestPurposeLabel.bottomAnchor, constant: 30),
            changeChoseDescriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            changeChoseDescriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            useAppLocationButton.topAnchor.constraint(equalTo: changeChoseDescriptionLabel.bottomAnchor, constant: 30),
            useAppLocationButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            useAppLocationButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            addMyselfLocationButton.topAnchor.constraint(equalTo: useAppLocationButton.bottomAnchor, constant: 10),
            addMyselfLocationButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            addMyselfLocationButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
    }
}
