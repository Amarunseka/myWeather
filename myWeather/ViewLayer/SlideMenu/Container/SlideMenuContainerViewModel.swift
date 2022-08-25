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
    func didTapMenuItem(mainVC: MainPageViewController, currentVC: inout UIViewController?, newVC: UIViewController){
        currentVC?.view.removeFromSuperview()
        currentVC?.didMove(toParent: nil)
        currentVC = nil
        
        if ((newVC as? MainPageViewController) == nil) {
            let vc = newVC
            mainVC.addChild(vc)
            mainVC.view.addSubview(vc.view)
            mainVC.navigationItem.rightBarButtonItem = nil
            
            vc.view.frame = mainVC.view.frame
            vc.didMove(toParent: mainVC)
            currentVC = vc
        } else {
            mainVC.navigationItem.rightBarButtonItem = mainVC.createRightBarButtonItem()
        }
    }
}
