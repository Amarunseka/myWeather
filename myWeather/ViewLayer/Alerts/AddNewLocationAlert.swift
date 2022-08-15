//
//  AddNewLocationAlert.swift
//  myWeather
//
//  Created by Миша on 14.08.2022.
//

import UIKit

class AddNewLocationAlert: UIView {
    
    // MARK: - Initial properties
    private var vc: UIViewController
    var outputText: ((String)->())?
    
    private let alert  = UIAlertController(title: "Add new location", message: "inter City name", preferredStyle: .alert)
    private let cancel = UIAlertAction(title: "Cancel", style: .destructive)

    private lazy var ok = UIAlertAction(title: "OK", style: .default) { [weak self] _ in
        guard let self = self else {return}
        
        guard let textField = self.alert.textFields?[0],
              let text = textField.text,
              let output = self.outputText else {return}
        output(text)
        self.alert.textFields?[0].text = nil
    }
    
    // MARK: - Life cycle
    init(vc: UIViewController) {
        self.vc = vc
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    private func setupView(){
        self.alert.addTextField { (textField) in
            textField.placeholder = "City"
        }
        
        alert.textFields?[0].addTarget(self, action: #selector(self.activateOKButton), for: .allEvents)
        
        ok.isEnabled = false
        alert.addAction(ok)
        alert.addAction(cancel)
    }
    
    @objc
    private func activateOKButton() {
        if alert.textFields?[0].text?.count != 0 {
            ok.isEnabled = true
        } else {
            ok.isEnabled = false
        }
    }
    
    // MARK: - Public methods
    public func presentAlert(){
        vc.present(alert, animated: true)
    }
}

// MARK: - Set constraints
