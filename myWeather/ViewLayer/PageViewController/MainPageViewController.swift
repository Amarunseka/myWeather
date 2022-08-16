//
//  MainPageViewController.swift
//  myWeather
//
//  Created by Миша on 15.08.2022.
//

import UIKit

class MainPageViewController: UIPageViewController {
    
    // MARK: - Initial properties
    weak var delegateTapMenu: SlideMenuButtonTapProtocol?
    private var cities = UserDefaultsManager.shared.cities[.cities]
    private let titleLabel = UILabel.setBlackLabel(text: "", fontSize: 18, fontStyle: .regular)

    private lazy var viewControllersArray: [MainViewController] = {
        var controllers = [MainViewController]()
        cities?.forEach{
            controllers.append(createViewControllers(cityInfo: $0))
        }
        return controllers
    }()


    // MARK: - Life cycle
    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
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
        setViewControllers([viewControllersArray[0]], direction: .forward, animated: true, completion: nil)
        setupNavigationBar()
        NotificationCenter.default.addObserver(self, selector: #selector(addNewLocation), name: Notification.Name("addLocation"), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        for subView in view.subviews {
            if subView is UIPageControl {
                subView.frame.origin.y = 80
                if let subView = subView as? UIPageControl {
                    subView.pageIndicatorTintColor = .lightGray
                    subView.currentPageIndicatorTintColor = .black
                    titleLabel.text = cities?[subView.currentPage].location.convertCityLocation()
                }
            }
        }
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
    }
    
    
    private func createViewControllers(cityInfo: CityCoordinatesModel) -> MainViewController{
        let vm = MainViewModel(cityInfo: cityInfo)
        let vc = MainViewController(viewModel: vm)
        return vc
    }
    
    private func setupNavigationBar(){
        let slideMenuButton: UIButton = {
            let button = UIButton(type: .system)
            let image = UIImage(named: "slideMenuIcon")
            button.frame = CGRect(x: 0, y: 0, width: 30, height: 16)
            button.setBackgroundImage(image, for: .normal)
            button.addTarget(self, action: #selector(didSlideMenuTap), for: .touchUpInside)
            return button
        }()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: slideMenuButton)
        
        
        let geolocationButton: UIButton = {
            let button = UIButton(type: .system)
            let image = UIImage(named: "geolocationIcon")
            button.frame = CGRect(x: 0, y: 0, width: 20, height: 16)
            button.setBackgroundImage(image, for: .normal)
            button.addTarget(self, action: #selector(didGeolocationTap), for: .touchUpInside)
            return button
        }()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: geolocationButton)
    }
    
    @objc
    private func didSlideMenuTap(){
        delegateTapMenu?.didTapSlideMenu()
    }
    
    
    @objc
    private func didGeolocationTap(){
        print("didGeolocationTap")
        // очистка USERDefaults
        UserDefaults.standard.removeObject(forKey: UserDefaultsNames.cities.rawValue)
    }
    
    @objc
    private func addNewLocation(){
        let cities = UserDefaultsManager.shared.cities[.cities]
        
        let viewControllersArray: [MainViewController] = {
            var controllers = [MainViewController]()
            cities?.forEach{
                controllers.append(createViewControllers(cityInfo: $0))
            }
            return controllers
        }()
        
        self.cities = cities
        self.viewControllersArray = viewControllersArray
        setViewControllers([viewControllersArray[0]], direction: .forward, animated: true, completion: nil)
    }


    // MARK: - Public methods

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
              let cities = cities else {return nil}
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
