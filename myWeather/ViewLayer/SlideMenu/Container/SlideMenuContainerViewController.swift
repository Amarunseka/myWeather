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
    private let mainScreenVC = MainViewController()
    
    private var slideMenuState: SlideMenuState = .closed
    private lazy var currentVC = UIViewController()


    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        addChildVC()
    }
    
    
    // MARK: - Private methods
    private func addChildVC(){
        slideMenuVC.viewModel.delegate = self
        addChild(slideMenuVC)
        self.view.addSubview(slideMenuVC.view)
        slideMenuVC.didMove(toParent: self)
        
        mainScreenVC.viewModel.delegate = self
        let navVC = UINavigationController(rootViewController: mainScreenVC)
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
//        toggleSlideMenu()
        viewModel.toggleSlideMenu(navVC: navVC, vc: mainScreenVC)
    }

    private func toggleSlideMenu() {
        switch slideMenuState {
        case .closed:
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           usingSpringWithDamping: 0.8,
                           initialSpringVelocity: 0,
                           options: .curveEaseInOut) {
                self.navVC.view.frame.origin.x = self.mainScreenVC.view.frame.size.width - 100
            } completion: { [weak self] done in
                if done {
                    self?.slideMenuState = .opened
                }
            }
            
        case .opened:
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           usingSpringWithDamping: 0.8,
                           initialSpringVelocity: 0,
                           options: .curveEaseInOut) {
                self.navVC.view.frame.origin.x = 0
            } completion: { [weak self] done in
                if done {
                    self?.slideMenuState = .closed
                }
            }
        }
    }
}


// MARK: - SlideMenuItemsTapProtocol Delegate
extension SlideMenuContainerViewController: SlideMenuItemsTapProtocol {
    func didSelectMenuItem(menuItem: SlideMenuViewModel.MenuItems) {
//        toggleSlideMenu()
        viewModel.toggleSlideMenu(navVC: navVC, vc: mainScreenVC)

        goToEditingVC(vc: menuItem.currentVC)
    }
    
    // ТУТ ИЗ ЗА ТОГО ЧТО СТАЮТСЯ ТАБ БАР АЙТЕМ ВОЗМОЖНО НУЖНО СДЕЛАТЬ ФУНКЦИЮ ВОЗВРАТА
    private func goToEditingVC(vc: UIViewController){
        self.currentVC.view.removeFromSuperview()
        self.currentVC.didMove(toParent: nil)

        let vc = vc
        self.mainScreenVC.addChild(vc)
        self.mainScreenVC.view.addSubview(vc.view)
        vc.view.frame = self.view.frame
        vc.didMove(toParent: mainScreenVC)
        self.mainScreenVC.title = vc.title
        self.currentVC = vc
    }
}
