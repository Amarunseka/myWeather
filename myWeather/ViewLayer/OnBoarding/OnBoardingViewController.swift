//
//  OnBoardingViewController.swift
//  myWeather
//
//  Created by Миша on 08.08.2022.
//

import UIKit
import CoreLocation

class OnBoardingViewController: UIViewController {
        
    // MARK: - Initial properties
    private var location: LocalCoordinates?
    private let sizes = SizesStorage.self
    private let imageView = UIImageView.setImage("onBoardingImage")
    private lazy var requestDescriptionLabel = UILabel.setWhiteLabel(text: "Do allow the Weather app to use your device's location?", fontSize: sizes.fontSizes.bigFontSize, fontStyle: .medium)
    private lazy var descriptionRequestPurposeLabel = UILabel.setWhiteLabel(text: "To get more accurate weather forecast while driving or traveling", fontSize: sizes.fontSizes.bigFontSize, fontStyle: .regular)
    private lazy var changeChoseDescriptionLabel = UILabel.setWhiteLabel(text: "You can change your choice at any time in your app's menu", fontSize: sizes.fontSizes.bigFontSize, fontStyle: .regular)
    private lazy var useAppLocationButton = UIButton.setButton(title: "use the application's location", color: .specialOrange, fontSize: sizes.fontSizes.bigFontSize)
    private lazy var addMyselfLocationButton = UIButton.setButton(title: "NO, I'LL ADD A LOCATION BY MYSELF", color: .clear, fontSize: sizes.fontSizes.bigFontSize)
    

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
        useAppLocationButton.backgroundColor = .specialOrange
        addMyselfLocationButton.backgroundColor = .clear
        self.location = LocalCoordinates(goToLocation: goToCurrentLocation)
        UserDefaults.standard.set(true, forKey: "isNewUser")
        dismiss(animated: true)
    }
    
    private func goToCurrentLocation(coordinate: CLLocationCoordinate2D) {
        let longitude = "\(coordinate.longitude)"
        let latitude = "\(coordinate.latitude)"
        getCityInfo(longitude: longitude, latitude: latitude)
    }
    
    @objc
    private func didAddMyselfLocationButton(){
        useAppLocationButton.backgroundColor = .clear
        addMyselfLocationButton.backgroundColor = .specialOrange
        NotificationCenter.default.post(name: Notification.Name("noLocation"), object: nil)
        UserDefaults.standard.set(true, forKey: "isNewUser")
        dismiss(animated: true)
    }
    
    


    // MARK: - Public methods
}

// MARK: - Set constraints
extension OnBoardingViewController {
    private func setConstraints(){
        NSLayoutConstraint.activate([
            
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: sizes.onBoardingSizes.imageSize / 2),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            imageView.heightAnchor.constraint(equalToConstant: sizes.onBoardingSizes.imageSize),
            imageView.widthAnchor.constraint(equalToConstant: sizes.onBoardingSizes.imageSize),
            
            requestDescriptionLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: sizes.onBoardingSizes.topSpacing * 5),
            requestDescriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: sizes.onBoardingSizes.sideSpacing),
            requestDescriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -sizes.onBoardingSizes.sideSpacing),

            descriptionRequestPurposeLabel.topAnchor.constraint(equalTo: requestDescriptionLabel.bottomAnchor, constant: sizes.onBoardingSizes.topSpacing * 5),
            descriptionRequestPurposeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: sizes.onBoardingSizes.sideSpacing),
            descriptionRequestPurposeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -sizes.onBoardingSizes.sideSpacing),

            changeChoseDescriptionLabel.topAnchor.constraint(equalTo: descriptionRequestPurposeLabel.bottomAnchor, constant: sizes.onBoardingSizes.topSpacing),
            changeChoseDescriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: sizes.onBoardingSizes.sideSpacing),
            changeChoseDescriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -sizes.onBoardingSizes.sideSpacing),

            
            addMyselfLocationButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: sizes.onBoardingSizes.sideSpacing),
            addMyselfLocationButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -sizes.onBoardingSizes.sideSpacing),
            addMyselfLocationButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -sizes.onBoardingSizes.topSpacing * 3),

            useAppLocationButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: sizes.onBoardingSizes.sideSpacing),
            useAppLocationButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -sizes.onBoardingSizes.sideSpacing),
            useAppLocationButton.bottomAnchor.constraint(equalTo: addMyselfLocationButton.topAnchor, constant: -sizes.onBoardingSizes.topSpacing * 2),
        ])
    }
}


// MARK: - Set coordinates
extension OnBoardingViewController {

    func getCityInfo(longitude: String, latitude: String) {
        Task {
            do {
                let cityInfo = try await NetworkRequest.shared.requestCityByCoordinates(longitude: longitude, latitude: latitude)
                let (longitude, latitude, address) = self.convertCityInfo(data: cityInfo)
                
                let data = CityCoordinatesModel(location: address, latitude: latitude, longitude: longitude)
                print(data)
                UserDefaultsManager.shared.cities.append(data)
                let model = UserDefaultsManager.shared.cities
                
                try await UserDefaultsManager.shared.save(key: .cities, model: model)
                NotificationCenter.default.post(name: Notification.Name("addLocation"), object: nil)
            } catch {
                print(error)
            }
        }
    }

    // MARK: - Private methods
    private func convertCityInfo(data: CityInfoModelContainer?) -> (String, String, String){
        
        if let data = data {
            let addressArray = data.address.split(separator: ",")
            let address = ("\(addressArray[0]),\(addressArray[1])")

            let coordinatesArray = data.coordinates.split(separator: " ")
            let longitude = coordinatesArray[0]
            let latitude = coordinatesArray[1]
            return("\(longitude)", "\(latitude)", "\(address)")
        } else {
            return ("","","")
        }
    }
}
