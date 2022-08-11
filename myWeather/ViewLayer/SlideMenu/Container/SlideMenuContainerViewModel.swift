//
//  SlideMenuContainerViewModel.swift
//  myWeather
//
//  Created by Миша on 11.08.2022.
//

import UIKit

enum SlideMenuState {
    case closed, opened
}

class SlideMenuContainerViewModel {
    
    private var slideMenuState: SlideMenuState = .closed

    func toggleSlideMenu(navVC: UINavigationController, vc: UIViewController) {
        switch slideMenuState {
        case .closed:
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           usingSpringWithDamping: 0.8,
                           initialSpringVelocity: 0,
                           options: .curveEaseInOut) {
                navVC.view.frame.origin.x = vc.view.frame.size.width - 100
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
                navVC.view.frame.origin.x = 0
            } completion: { [weak self] done in
                if done {
                    self?.slideMenuState = .closed
                }
            }
        }
    }

}
