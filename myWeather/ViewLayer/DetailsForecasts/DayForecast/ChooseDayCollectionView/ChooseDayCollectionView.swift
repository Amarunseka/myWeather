//
//  ChooseDayCollectionView.swift
//  myWeather
//
//  Created by Миша on 09.08.2022.
//

import UIKit

class ChooseDayCollectionView: UICollectionView {
    
    // MARK: - Initial properties
    var itemNames = [String]()
    var didSelectItem: ((IndexPath)->())?


    // MARK: - Life cycle
    init(){
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        super.init(frame: .zero, collectionViewLayout: layout)
        
        backgroundColor = nil
        delegate = self
        dataSource = self
        
        register(ChooseDayCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: ChooseDayCollectionViewCell.self))
        layout.minimumLineSpacing = 10
        
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Private methods



// MARK: - Public methods



// MARK: - Set UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
extension ChooseDayCollectionView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        itemNames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ChooseDayCollectionViewCell.self), for: indexPath) as? ChooseDayCollectionViewCell else {return UICollectionViewCell()}
        cell.nameLabel.text = itemNames[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 30)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        15
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let didSelectItem = didSelectItem else {return}
        didSelectItem(indexPath)
    }
}
