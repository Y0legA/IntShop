//
//  ForYouViewController.swift
//  InternetShopDZ
//
//  Created by Oleg_Yakovlev on 6.10.22.
//

import UIKit
// Экран предпочтений
final class ForYouViewController: UIViewController {
    // MARK: - LyfeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Private Methods
    private func configureUI() {
        view.backgroundColor = .systemBackground
    }
}
