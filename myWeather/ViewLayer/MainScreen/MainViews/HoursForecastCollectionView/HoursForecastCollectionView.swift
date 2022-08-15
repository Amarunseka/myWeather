//
//  HoursForecastCollectionView.swift
//  myWeather
//
//  Created by Миша on 04.08.2022.
//

import UIKit

class HoursForecastCollectionView: UICollectionView {

    // MARK: - Initial properties
    let cellWidth: CGFloat
    var hoursForecasts = [Hour]()
    

    // MARK: - Life cycle
    init(cellWidth: CGFloat){
        self.cellWidth = cellWidth
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        super.init(frame: .zero, collectionViewLayout: layout)
        
        backgroundColor = nil
        delegate = self
        dataSource = self
        
        register(HoursForecastCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: HoursForecastCollectionViewCell.self))
        layout.minimumLineSpacing = 10
        
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
        selectToCurrentItem()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    
    // MARK: - Public methods
    func selectToCurrentItem(){
        let currentHour: Int?
        if let wind = UserDefaultsManager.shared.settings.first?.value,
           wind.timeFormatMode == 0 {
            currentHour = Int(Date().toString(type: .hour).dropLast(3))
        } else {
            currentHour = Int(Date().toString(type: .hour))
        }
        
        guard let currentHour = currentHour,
              !hoursForecasts.isEmpty else {return }
        
        selectItem(at: [0, currentHour], animated: true, scrollPosition: .centeredHorizontally)
        scrollToItem(at: [0, currentHour], at: .centeredHorizontally, animated: false)
    }
}


// MARK: - Set UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
extension HoursForecastCollectionView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return hoursForecasts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: HoursForecastCollectionViewCell.self), for: indexPath) as? HoursForecastCollectionViewCell else {return UICollectionViewCell()}

        cell.data = hoursForecasts[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: cellWidth, height: 84)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        15
    }
}
