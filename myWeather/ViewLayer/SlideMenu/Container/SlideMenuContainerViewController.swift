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
    private let mainVC = MainPageViewController()
    private var currentVC: UIViewController?


    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        addChildVC()
        NotificationCenter.default.addObserver(self, selector: #selector(goToMain), name: Notification.Name("addLocation"), object: nil)
    }
    
    
    // MARK: - Private methods
    private func addChildVC(){
        slideMenuVC.viewModel.delegate = self
        addChild(slideMenuVC)
        self.view.addSubview(slideMenuVC.view)
        slideMenuVC.didMove(toParent: self)

        mainVC.delegateTapMenu = self
        let navVC = UINavigationController(rootViewController: mainVC)
        addChild(navVC)
        self.view.addSubview(navVC.view)
        navVC.didMove(toParent: self)
        self.navVC = navVC
    }
    
    @objc
    private func goToMain(){
        viewModel.goToMain(currentVC: &currentVC)
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
        viewModel.didTapMenuItem(mainVC: mainVC, currentVC: &currentVC, newVC: menuItem.chosenVC)
    }
}
