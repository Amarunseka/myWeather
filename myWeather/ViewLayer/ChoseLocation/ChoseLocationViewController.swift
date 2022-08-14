//
//  ChoseLocationViewController.swift
//  myWeather
//
//  Created by Миша on 04.08.2022.
//

import UIKit

class ChoseLocationViewController: UIViewController {
  
    // MARK: - Initial properties
    private lazy var addLocationButton: UIButton = {
        let button = UIButton(type: .system)
        button.setBackgroundImage(UIImage(systemName: "plus"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(didTapAddLocationButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var addNewLocationAlert = AddNewLocationAlert(vc: self)

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAddNewLocationAlert()
        setupView()
        setConstraints()
    }


    // MARK: - Private methods
    private func setupView(){
        self.title = "Chose location"
        view.backgroundColor = .cyan
        [addLocationButton,
        ].forEach{
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
    }
    
    private func setupAddNewLocationAlert(){
        view.addSubview(addNewLocationAlert)

        addNewLocationAlert.outputText = { [weak self ] city in
            guard let self = self else {return}
            self.getCityInfo(city: city)
        }
    }
    
    func getCityInfo(city: String) {
        
        Task {
            do {
                let cityInfo = try await NetworkRequest.shared.requestCityCoordinates(for: city)
                let (longitude, latitude, address) = self.convertCityInfo(data: cityInfo)
                let weatherData = try await NetworkRequest.shared.requestSpecificCityWeatherData(latitude: latitude, longitude: longitude)
                print(address, weatherData.info.url)
            }
        }
    }
    
    @objc
    private func didTapAddLocationButton(){
        addNewLocationAlert.presentAlert()
    }
    
    private func convertCityInfo(data: CityInfoModel?) -> (String, String, String){
        if let coder = data?.response.geoObjectCollection.featureMember,
           !coder.isEmpty {
            let coordinates = coder[0].geoObject.point
            let coordinatesArray = coordinates.pos.split(separator: " ")
            
            let longitude = coordinatesArray[0]
            let latitude = coordinatesArray[1]
            let address = coder[0].geoObject.metaDataProperty.geocoderMetaData.address.formatted
            
            return("\(longitude)", "\(latitude)", "\(address)")
        }
        return ("","","")
    }


    // MARK: - Public methods


}
// MARK: - Set constraints
extension ChoseLocationViewController{
    private func setConstraints(){
        NSLayoutConstraint.activate([
            addLocationButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            addLocationButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0),
            addLocationButton.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -view.frame.size.width/1.5),
            addLocationButton.heightAnchor.constraint(equalTo: addLocationButton.widthAnchor)
        ])
    }
}
