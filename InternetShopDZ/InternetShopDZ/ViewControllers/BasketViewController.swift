//
//  BasketViewController.swift
//  InternetShopDZ
//
//  Created by Oleg_Yakovlev on 6.10.22.
//

import UIKit

// Экран корзины покупок
final class BasketViewController: UIViewController {
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
   
    // MARK: - Private Methods
    private func configureUI() {
        view.backgroundColor = .systemBackground
    }
}
