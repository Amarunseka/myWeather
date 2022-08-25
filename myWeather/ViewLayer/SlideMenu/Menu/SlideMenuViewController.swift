//
//  SlideMenuViewController.swift
//  myWeather
//
//  Created by Миша on 04.08.2022.
//

import UIKit


class SlideMenuViewController: UIViewController {

    // MARK: - Initial properties
    let viewModel: SlideMenuViewModel
    private lazy var tableView = SlideMenuTableView(didTapDelegate: viewModel.delegate)

    // MARK: - Life cycle
    init(viewModel: SlideMenuViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.frame
    }
    
    // MARK: - Private methods
    private func setupView(){
        view.backgroundColor = .specialDarkBlue
        
        [tableView
        ].forEach {
            self.view.addSubview($0)
        }
    }
}
