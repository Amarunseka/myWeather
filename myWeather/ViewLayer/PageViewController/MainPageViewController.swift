//
//  MainPageViewController.swift
//  myWeather
//
//  Created by Миша on 15.08.2022.
//

import UIKit

class MainPageViewController: UIPageViewController {
    
    // MARK: - Initial properties
    private var viewControllersArray = [UIViewController]()


    // MARK: - Life cycle
    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        delegate = self
        dataSource = self

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        for subView in view.subviews {
            if subView is UIPageControl {
                subView.frame.origin.y = 75
            }
        }
    }

    // MARK: - Private methods



    // MARK: - Public methods



}

// MARK: - UIPageViewControllerDelegate, UIPageViewControllerDataSource
extension MainPageViewController: UIPageViewControllerDelegate,UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        nil
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return viewControllersArray.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
}
