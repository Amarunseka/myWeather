//
//  MainPageViewController.swift
//  myWeather
//
//  Created by Миша on 15.08.2022.
//

import UIKit

class MainPageViewController: UIPageViewController {
    
    // MARK: - Initial properties
    let viewModel: MainPageViewModel
    private let titleLabel = UILabel.setBlackLabel(text: "", fontSize: 18, fontStyle: .regular)
    private lazy var viewControllersArray: [MainViewController] = viewModel.createViewController()

    
    // MARK: - Life cycle
    init(viewModel: MainPageViewModel) {
        self.viewModel = viewModel
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        dataSource = self
        setupView()
        setupNavigationBar()
        NotificationCenter.default.addObserver(self, selector: #selector(addNewLocation), name: Notification.Name("addLocation"), object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if viewModel.cities?.count == 0 {
            NotificationCenter.default.post(name: Notification.Name("noLocation"), object: nil)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupPageControl()
        setConstraints()
    }


    // MARK: - Private methods
    private func setupView(){
        view.backgroundColor = .clear
        
        [titleLabel].forEach{
            $0.textAlignment = .center
            $0.adjustsFontSizeToFitWidth = true
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        if !viewControllersArray.isEmpty {
            setViewControllers([viewControllersArray[0]], direction: .forward, animated: true, completion: nil)
        }
    }

    private func setupNavigationBar(){
        let slideMenuButton = UIButton.setNavItemButton(image: "slideMenuIcon", width: 30)
        slideMenuButton.addTarget(self, action: #selector(didSlideMenuTap), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: slideMenuButton)

        self.navigationItem.rightBarButtonItem = createRightBarButtonItem()
    }
    
    private func setupPageControl(){
        let cities = viewModel.cities
        for subView in view.subviews {
            if subView is UIPageControl,
               let subView = subView as? UIPageControl {
                subView.frame.origin.y = 80
                subView.pageIndicatorTintColor = .lightGray
                
                (cities?.count ?? 0) > 1
                ? (subView.currentPageIndicatorTintColor = .black)
                : (subView.currentPageIndicatorTintColor = .clear)
                
                if cities?.count != 0 {
                    titleLabel.text = cities?[subView.currentPage].location.convertCityLocation()
                }
            }
        }
    }
    
    @objc
    private func didSlideMenuTap(){
        viewModel.delegateTapMenu?.didTapSlideMenu()
    }
    
    @objc
    private func didGeolocationTap(){
        print("didGeolocationTap")
//         очистка USERDefaults
//        UserDefaults.standard.removeObject(forKey: UserDefaultsNames.cities.rawValue)
    }
    
    @objc
    private func addNewLocation(){
        let cities = UserDefaultsManager.shared.cities[.cities]
        self.viewModel.cities = cities

        let viewControllersArray = viewModel.createViewController()
        
        self.viewControllersArray = viewControllersArray
        setViewControllers([self.viewControllersArray[0]], direction: .forward, animated: true, completion: nil)
        
        if cities?.count == 1 {
            titleLabel.text = cities?[0].location.convertCityLocation()
        }
    }


    // MARK: - Public methods
    public func createRightBarButtonItem() -> UIBarButtonItem {
        let geolocationButton = UIButton.setNavItemButton(image: "geolocationIcon", width: 20)
        geolocationButton.addTarget(self, action: #selector(didGeolocationTap), for: .touchUpInside)
        let item = UIBarButtonItem(customView: geolocationButton)
        return item
    }
}

// MARK: - UIPageViewControllerDelegate, UIPageViewControllerDataSource
extension MainPageViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let vc = viewController as? MainViewController else {return nil}
        if let index = viewControllersArray.firstIndex(of: vc),
           index > 0 {
            return viewControllersArray[index - 1]
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let vc = viewController as? MainViewController,
              let cities = viewModel.cities else {return nil}
        if let index = viewControllersArray.firstIndex(of: vc),
           index < cities.count - 1 {
            return viewControllersArray[index + 1]
        }
        return nil
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return viewControllersArray.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
//    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
//        if completed {
//            if let currentViewController = pageViewController.viewControllers?.first,
//               let index = viewControllersArray.firstIndex(of: currentViewController as! MainViewController) {
//                titleLabel.text = cities?[index].location.convertCityLocation()
//            }
//        }
//    }
}

extension MainPageViewController {
    private func setConstraints(){
        NSLayoutConstraint.activate([
            titleLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -10),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 70),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -70),
        ])
    }
}
