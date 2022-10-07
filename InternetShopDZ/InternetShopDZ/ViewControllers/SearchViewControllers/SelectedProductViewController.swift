//
//  SelectedProductViewController.swift
//  InternetShopDZ
//
//  Created by Oleg_Yakovlev on 6.10.22.
//

import UIKit

// Экран выбранного товара
final class SelectedProductViewController: UIViewController {
    
    // MARK: - Visual Components
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = productName
        label.textColor = .label
        label.font = UIFont(name: "Avenir Next Demi Bold", size: 15)
        label.textAlignment = .center
        label.frame = CGRect(x: 0, y: view.frame.minY + 50, width: view.frame.width, height: 50)
        return label
    }()
    
    private lazy var productImageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: nameLabel.frame.minY + 100,
                                                  width: view.frame.width - 100, height: view.frame.height / 3))
        imageView.center.x = view.center.x
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: productImageName)
        return imageView
    }()
    
    // MARK: - Public Properties
    var productName = ""
    var productImageName = ""
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Private Actions
    private func configureUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(nameLabel)
        view.addSubview(productImageView)
    }
}
    
