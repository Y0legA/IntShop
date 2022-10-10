//
//  Product.swift
//  InternetShopDZ
//
//  Created by Oleg_Yakovlev on 9.10.22.
//

import UIKit

// Класс товара
final class Product: UIView {
    // MARK: - Visual Components
    private lazy var productImageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 25, y: 10, width: 70, height: 70))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var nameProductLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = UIFont(name: "Avenir Next Demi Bold", size: 9)
        label.numberOfLines = 0
        label.textAlignment = .justified
        label.frame = CGRect(x: 10, y: 93, width: 100, height: 37)
        return label
    }()
    
    // MARK: - Initializers
    init(parameter: ProductInfo) {
        super.init(frame: .zero)
        productImageView.image = UIImage(named: parameter.productImageName)
        nameProductLabel.text = parameter.productName
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor =  #colorLiteral(red: 0.1107899025, green: 0.1054661646, blue: 0.1186901554, alpha: 1)
        layer.cornerRadius = 10
        frame.size = CGSize(width: 120, height: 150)
    }
    
    // MARK: - Private Methods
    private func configureUI() {
        addSubview(productImageView)
        addSubview(nameProductLabel)
    }
}
