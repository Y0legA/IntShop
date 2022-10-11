//
//  TabBarViewController.swift
//  InternetShopDZ
//
//  Created by Oleg_Yakovlev on 6.10.22.
//

import UIKit

// Экран таббара
final class TabBarViewController: UITabBarController {
    private enum Constants {
        static let buy = "Купить"
        static let forYou = "Для вас"
        static let search = "Поиск"
        static let basket = "Корзина"
        static let laptopIcon = "laptop_icon"
        static let searchIcon = "magnifyingglass"
        static let bagIcon = "bag"
        static let personIcon = "person.circle"
    }
    
    // MARK: - Private Visual Components
    private lazy var buyViewController: BuyViewController = {
        let viewController = BuyViewController()
        viewController.tabBarItem = UITabBarItem(title: Constants.buy,
                                                 image: UIImage(named: Constants.laptopIcon), tag: 0)
        return viewController
    }()
    
    private lazy var searchViewController: SearchViewController = {
        let viewController = SearchViewController()
        viewController.tabBarItem = UITabBarItem(title: Constants.search,
                                                 image: UIImage(systemName: Constants.searchIcon), tag: 1)
        return viewController
    }()
    
    private lazy var forYouViewController: ForYouViewController = {
        let viewController = ForYouViewController()
        viewController.tabBarItem = UITabBarItem(title: Constants.forYou,
                                                 image: UIImage(systemName: Constants.personIcon), tag: 2)
        return viewController
    }()
    
    private lazy var busketViewController: BasketViewController = {
        let viewController = BasketViewController()
        viewController.tabBarItem = UITabBarItem(title: Constants.basket,
                                                 image: UIImage(systemName: Constants.bagIcon), tag: 3)
        return viewController
    }()
    
    private lazy var searchNavigationController = UINavigationController(rootViewController: searchViewController)
    private lazy var forYouNavigationController = UINavigationController(rootViewController: forYouViewController)
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setStyleTabBar()
        setControllers()
    }

    // MARK: - Private Methods
    private func setControllers() {
        viewControllers = [buyViewController, forYouNavigationController,
                           searchNavigationController, busketViewController]
    }
    
    private func setStyleTabBar() {
        tabBar.backgroundColor = .systemBackground
        tabBar.unselectedItemTintColor = .systemGray2
    }
    
}
