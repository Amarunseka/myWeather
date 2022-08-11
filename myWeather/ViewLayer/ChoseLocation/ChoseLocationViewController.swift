//
//  ChoseLocationViewController.swift
//  myWeather
//
//  Created by Миша on 04.08.2022.
//

import UIKit

class ChoseLocationViewController: UIViewController {
  
    // MARK: - Initial properties


    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }


    // MARK: - Private methods
    private func setupView(){
        self.title = "Chose location"

        view.backgroundColor = .cyan
    }


    // MARK: - Public methods


}
// MARK: - Set constraints
