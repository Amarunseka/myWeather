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
    
    
    // ТУТ ИЗ ЗА ТОГО ЧТО СТАЮТСЯ ТАБ БАР АЙТЕМ ВОЗМОЖНО НУЖНО СДЕЛАТЬ ФУНКЦИЮ ВОЗВРАТА
    func goToNewVC(mainVC: UIViewController, currentVC: inout UIViewController, newVC: UIViewController){
        currentVC.view.removeFromSuperview()
        currentVC.didMove(toParent: nil)

        let vc = newVC
        mainVC.addChild(vc)
        mainVC.view.addSubview(vc.view)
        newVC.view.frame = mainVC.view.frame
        newVC.didMove(toParent: mainVC)
        mainVC.title = newVC.title
        currentVC = newVC
    }
}
