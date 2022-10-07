//
//  TabBarViewController.swift
//  InternetShopDZ
//
//  Created by Oleg_Yakovlev on 6.10.22.
//

import UIKit

// Экран таббара
final class TabBarViewController: UITabBarController {
    // MARK: - Private Visual Components
    private lazy var buyViewController: BuyViewController = {
        let viewController = BuyViewController()
        viewController.tabBarItem = UITabBarItem(title: "Купить",
                                                 image: UIImage(named: "laptop_icon"), tag: 0)
        return viewController
    }()
    
    private lazy var searchViewController: SearchViewController = {
        let viewController = SearchViewController()
        viewController.tabBarItem = UITabBarItem(title: "Поиск",
                                                 image: UIImage(systemName: "magnifyingglass"), tag: 1)
        return viewController
    }()
    
    private lazy var forYouViewController: ForYouViewController = {
        let viewController = ForYouViewController()
        viewController.tabBarItem = UITabBarItem(title: "Для вас",
                                                 image: UIImage(systemName: "person.circle"), tag: 2)
        return viewController
    }()
    
    private lazy var busketViewController: BasketViewController = {
        let viewController = BasketViewController()
        viewController.tabBarItem = UITabBarItem(title: "Корзина",
                                                 image: UIImage(systemName: "bag"), tag: 3)
        return viewController
    }()
    
    private lazy var searchNavigationController = UINavigationController(rootViewController: searchViewController)

    // MARK: - LifeCycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setControllers()
    }

    // MARK: - Private Methods
    private func setControllers() {
        viewControllers = [buyViewController, forYouViewController, searchNavigationController, busketViewController]
        tabBar.barTintColor = .black
    }
}
