//
//  SlideMenuContainerViewController.swift
//  myWeather
//
//  Created by Миша on 04.08.2022.
//

import UIKit

class SlideMenuContainerViewController: UIViewController {

    // MARK: - Initial properties
    private let viewModel = SlideMenuContainerViewModel()
    
    private var navVC = UINavigationController()
    private let slideMenuVC = SlideMenuViewController()
    private let mainVC = MainViewController()
    private lazy var currentVC = UIViewController()


    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        addChildVC()
    }
    
    
    // MARK: - Private methods
    private func addChildVC(){
        slideMenuVC.viewModel.delegate = self
        addChild(slideMenuVC)
        self.view.addSubview(slideMenuVC.view)
        slideMenuVC.didMove(toParent: self)

        mainVC.viewModel.delegate = self
        let navVC = UINavigationController(rootViewController: mainVC)
        addChild(navVC)
        self.view.addSubview(navVC.view)
        navVC.didMove(toParent: self)
        self.navVC = navVC
    }
}

// MARK: - Public methods

// MARK: - SlideMenuButtonTap Delegate
extension SlideMenuContainerViewController: SlideMenuButtonTapProtocol {
    func didTapSlideMenu() {
        viewModel.toggleSlideMenu(navVC: navVC, vc: mainVC)
    }
}

// MARK: - SlideMenuItemsTapProtocol Delegate
extension SlideMenuContainerViewController: SlideMenuItemsTapProtocol {
    func didSelectMenuItem(menuItem: SlideMenuViewModel.MenuItems) {
        viewModel.toggleSlideMenu(navVC: navVC, vc: mainVC)
        viewModel.goToNewVC(mainVC: mainVC, currentVC: &currentVC, newVC: menuItem.currentVC)
    }
}
