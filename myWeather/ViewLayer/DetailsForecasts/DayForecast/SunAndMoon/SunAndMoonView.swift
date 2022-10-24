//
//  SunAndMoonView.swift
//  myWeather
//
//  Created by Миша on 09.08.2022.
//

import UIKit

class SunAndMoonView: UIView {
    
    // MARK: - Initial properties

    // MARK: - Life cycle
    init(){

        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setFrames()
        setConstraints()
    }
    
    // MARK: - Private methods
    private func setupView(){
        backgroundColor = .specialLightBlue
    }

    
    private func setFrames(){

    }

    // MARK: - Public methods

}

// MARK: - Set constraints
extension SunAndMoonView {
    private func setConstraints(){
        NSLayoutConstraint.activate([

        ])
    }
}
