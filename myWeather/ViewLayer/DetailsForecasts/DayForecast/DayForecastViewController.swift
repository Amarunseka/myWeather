//
//  DayForecastViewController.swift
//  myWeather
//
//  Created by Миша on 05.08.2022.
//

import UIKit

class DayForecastViewController: DetailsForecastCommonViewController {
    // MARK: - Initial properties
    private let viewModel: DayForecastViewModel
    private let partsOfTheDayDictionary = [String: PartOfTheDayModel]()
    private lazy var chooseDayCollectionView = ChooseDayCollectionView()
    private let scrollView = UIScrollView()
    private let containerView = UIView()

    private let dayForecastView = PartOfTheDayView(partName: "Day")
    private let nightForecastView = PartOfTheDayView(partName: "Night")
    private let sunAndMoon = SunAndMoonView()
    private let qualityOfAirView = QualityOfAirView()

    // MARK: - Life cycle
    init(viewModel: DayForecastViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupCollectionView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setConstraints()
    }

    // MARK: - Private methods
    private func setupView(){
        view.backgroundColor = .white
        titleLabel.text = viewModel.regionName
        scrollView.bounces = false
        dayForecastView.data = viewModel.weatherData[0].parts.day
        nightForecastView.data = viewModel.weatherData[0].parts.night

        
        [chooseDayCollectionView,
         scrollView
        ].forEach{
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        [containerView
        ].forEach{
            $0.translatesAutoresizingMaskIntoConstraints = false
            scrollView.addSubview($0)
        }

        [dayForecastView,
         nightForecastView,
         sunAndMoon,
         qualityOfAirView
        ].forEach{
            $0.translatesAutoresizingMaskIntoConstraints = false
            containerView.addSubview($0)
        }
    }
    
    private func setupCollectionView(){
        var names = [String]()
        viewModel.weatherData.forEach{
            names.append($0.dateTs.toDate().toString(type: .shortAndWDDate))
        }
        chooseDayCollectionView.itemNames = names
        chooseDayCollectionView.didSelectItem = { [weak self] index in
            guard let self = self else {return}
            self.didTapCollectionItem(index: index)
        }
        chooseDayCollectionView.reloadData()
        chooseDayCollectionView.selectToCurrentItem()
    }
    
    private func didTapCollectionItem(index: Int) {
        dayForecastView.data = viewModel.weatherData[index].parts.day
        nightForecastView.data = viewModel.weatherData[index].parts.night
    }

    // MARK: - Public methods

}
// MARK: - Set constraints
extension DayForecastViewController{
    private func setConstraints(){
        let sideSpacing = sizes.standartSpacingSizes.sideSpacing - 6
        NSLayoutConstraint.activate([
            chooseDayCollectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: sizes.barButtonItemSizes.menuIconWidth),
            chooseDayCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: sideSpacing),
            chooseDayCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: sideSpacing),
            chooseDayCollectionView.heightAnchor.constraint(equalToConstant: 50),
            
            scrollView.topAnchor.constraint(equalTo: chooseDayCollectionView.bottomAnchor, constant: sizes.standartSpacingSizes.sideSpacing),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: sideSpacing),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -sideSpacing),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),

            containerView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 0),
            containerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 0),
            containerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: 0),
            containerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 0),
            containerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            dayForecastView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: sizes.standartSpacingSizes.sideSpacing),
            dayForecastView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 0),
            dayForecastView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: 0),
            dayForecastView.heightAnchor.constraint(equalToConstant: sizes.cellSizes.parts.0),
            
            nightForecastView.topAnchor.constraint(equalTo: dayForecastView.bottomAnchor, constant: sizes.standartSpacingSizes.sideSpacing),
            nightForecastView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 0),
            nightForecastView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: 0),
            nightForecastView.heightAnchor.constraint(equalToConstant: sizes.cellSizes.parts.0),
            
            sunAndMoon.topAnchor.constraint(equalTo: nightForecastView.bottomAnchor, constant: sizes.standartSpacingSizes.sideSpacing),
            sunAndMoon.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 0),
            sunAndMoon.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: 0),
            sunAndMoon.heightAnchor.constraint(equalToConstant: view.frame.size.height / 6),

            qualityOfAirView.topAnchor.constraint(equalTo: sunAndMoon.bottomAnchor, constant: sizes.standartSpacingSizes.sideSpacing),
            qualityOfAirView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 0),
            qualityOfAirView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: 0),
            qualityOfAirView.heightAnchor.constraint(equalToConstant: view.frame.size.height / 6),
            qualityOfAirView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 0)
        ])
    }
}
