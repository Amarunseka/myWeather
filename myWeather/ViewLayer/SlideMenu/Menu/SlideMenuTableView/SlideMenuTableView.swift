//
//  SlideMenuTableView.swift
//  myWeather
//
//  Created by Миша on 09.08.2022.
//

import UIKit

class SlideMenuTableView: UITableView {

    // MARK: - Initial properties
    weak var didTapDelegate: SlideMenuItemsTapProtocol?

    // MARK: - Life cycle
    init(didTapDelegate: SlideMenuItemsTapProtocol?){
        self.didTapDelegate = didTapDelegate
        super.init(frame: .zero, style: .plain)
        setupView()
        NotificationCenter.default.addObserver(self, selector: #selector(reload), name: Notification.Name("addLocation"), object: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private methods
    private func setupView(){
        register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        backgroundColor = nil
        separatorStyle = .none
        rowHeight = 70

        delegate = self
        dataSource = self
    }
    
    @objc
    private func reload(){
            self.reloadData()
    }
}

// MARK: - Setup tableView UITableViewDataSource, UITableViewDelegate
extension SlideMenuTableView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        SlideMenuViewModel.MenuItems.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let image = UIImage(named: SlideMenuViewModel.MenuItems.allCases[indexPath.row].iconImage)?.withRenderingMode(.alwaysTemplate)

        cell.textLabel?.text = SlideMenuViewModel.MenuItems.allCases[indexPath.row].rawValue
        cell.textLabel?.textColor = .white
        cell.backgroundColor = .specialDarkBlue
        cell.contentView.backgroundColor = .specialDarkBlue
        cell.imageView?.image = image
        cell.imageView?.tintColor = .white
        
        switch indexPath.row {
        case 0:
            let cities = UserDefaultsManager.shared.cities[.cities]
            if cities?.count == 0 {
                cell.imageView?.alpha = 0.3
                cell.textLabel?.alpha = 0.3
                return cell
            } else {
                return cell
            }
        default:
            cell.imageView?.alpha = 1
            cell.textLabel?.alpha = 1
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = SlideMenuViewModel.MenuItems.allCases[indexPath.row]

        switch indexPath.row {
        case 0:
            let cities = UserDefaultsManager.shared.cities[.cities]
            if cities?.count == 0 {
            } else {
                fallthrough
            }
        default:
            didTapDelegate?.didSelectMenuItem(menuItem: item)
        }
    }
}
