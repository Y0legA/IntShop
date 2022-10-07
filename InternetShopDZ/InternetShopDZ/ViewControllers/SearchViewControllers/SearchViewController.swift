//
//  SearchViewController.swift
//  InternetShopDZ
//
//  Created by Oleg_Yakovlev on 5.10.22.
//

import UIKit

// Экран поиска товара
final class SearchViewController: UIViewController {
    private enum Constants {
        static let search = "Поиск"
        static let seed = "Недавно просмотренные"
        static let clean = "Очистить"
        static let requests = "Варианты запросов"
        static let fontAvenir = "Avenir Next Demi Bold"
        static let fontArial = "Arial"
        static let placeholder = "Поиск по продуктам и магазинам"
        static let goods = [("Чехол Incase Flat для MacBook Pro 16 дюймов", "Image"),
                            ("Спортивный ремешок Black Unity для (к...", "4"),
                            ("Чехол Incase Flat для MacBook Pro 16 дюймов", "2")
        ]
        static let textRequests = ["Air Pods", "Apple Care", "Beats", "Сравните модели iPhone"]
    }
    
    // MARK: - Visual Components
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.search
        label.textColor = .label
        label.font = UIFont(name: Constants.fontAvenir, size: 25)
        label.frame = CGRect(x: 0, y: view.frame.minY + 50, width: view.frame.width, height: 50)
        return label
    }()
    
    private lazy var productsSearchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = Constants.placeholder
        searchBar.frame = CGRect(x: 0, y: titleLabel.frame.maxY + 10, width: view.frame.width, height: 35)
        return searchBar
    }()
    
    private lazy var viewedLabel: UILabel = {
        var label = UILabel()
        label.text = Constants.seed
        label.textColor = .label
        label.font = UIFont(name: Constants.fontAvenir, size: 17)
        label.frame = CGRect(x: 0, y: productsSearchBar.frame.maxY + 35, width: view.frame.width / 3 * 2, height: 15)
        return label
    }()
    
    private lazy var clearButton: UIButton = {
        let button = UIButton()
        button.frame = CGRect(x: viewedLabel.frame.maxX,
                              y: viewedLabel.frame.minY + 2,
                              width: view.frame.width / 3,
                              height: viewedLabel.frame.height)
        button.titleLabel?.font = UIFont(name: Constants.fontArial, size: 14) ?? UIFont()
        button.setTitle(Constants.clean, for: .normal)
        button.contentHorizontalAlignment = .right
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        button.addTarget(self, action: #selector(clearSearchTextFieldAction), for: .touchDown)
        return button
    }()
    
    private lazy var productOneView = makeView(0, clearButton.frame.maxY + 10.0,
                                               Constants.goods[0].0, Constants.goods[0].1)
    private lazy var productTwoView = makeView(143, clearButton.frame.maxY + 10.0,
                                               Constants.goods[1].0, Constants.goods[1].1)
    private lazy var productThreeView = makeView(286, clearButton.frame.maxY + 10.0,
                                                 Constants.goods[2].0, Constants.goods[2].1)
    
    private lazy var requestsLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.requests
        label.textColor = .label
        label.font = UIFont(name: Constants.fontAvenir, size: 18)
        label.frame = CGRect(x: 0, y: productOneView.frame.maxY + 20.0, width: view.frame.width, height: 50)
        return label
    }()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Private Actions
    @objc private func handleTap(_ sender: UITapGestureRecognizer) {
        let productViewController = SelectedProductViewController()
        guard let index = sender.view?.tag else { return }
        productViewController.productName = Constants.goods[index].0
        productViewController.productImageName = Constants.goods[index].1
        navigationController?.pushViewController(productViewController, animated: true)
    }
    
    @objc private func clearSearchTextFieldAction() {
        productsSearchBar.text = ""
    }
    
    // MARK: - Private Methods
    private func configureUI() {
        configureView()
        makeRequestsLabel()
        addRecognizer()
    }
    
    private func configureView() {
        view.backgroundColor = .systemBackground
        view.addSubview(titleLabel)
        view.addSubview(productsSearchBar)
        view.addSubview(viewedLabel)
        view.addSubview(clearButton)
        view.addSubview(productOneView)
        view.addSubview(productTwoView)
        view.addSubview(productThreeView)
        view.addSubview(requestsLabel)
        
    }
    
    private func makeView(_ coordinateX: Double, _ coordinateY: Double, _ name: String, _ imageName: String) -> UIView {
        let view = UIView()
        view.frame = CGRect(x: coordinateX, y: coordinateY, width: 135, height: 180)
        let imageView = UIImageView()
        imageView.frame = CGRect(x: view.bounds.minX + 25, y: view.bounds.minY + 15, width: 80, height: 90)
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: imageName)
        view.addSubview(imageView)
        let label = UILabel()
        label.text = name
        label.textAlignment = .left
        label.textColor = .label
        label.font = UIFont(name: Constants.fontAvenir, size: 12)
        label.numberOfLines = 0
        label.textAlignment = .justified
        label.frame = CGRect(x: view.bounds.minX + 10, y: view.bounds.midY + 20, width: 100, height: 50)
        view.addSubview(label)
        view.layer.cornerRadius = 15
        view.backgroundColor = .systemGray6
        return view
    }
    
    private func makeRequestsLabel() {
        var yCoordinate: CGFloat = requestsLabel.frame.maxY + 8
        for textRequest in Constants.textRequests {
            let imageView = UIImageView(image: UIImage(systemName: "magnifyingglass"))
            imageView.tintColor = .gray
            imageView.frame = CGRect(x: 0, y: yCoordinate, width: 13, height: 13)
            let label = UILabel(frame: CGRect(x: imageView.frame.maxX + 10,
                                              y: imageView.frame.minY,
                                              width: view.frame.width - imageView.frame.width,
                                              height: imageView.frame.height))
            label.textColor = .label
            label.font = UIFont(name: Constants.fontArial, size: 17)
            label.text = textRequest
            let bottomLine = CALayer()
            bottomLine.frame = CGRect(x: 0.0,
                                      y: label.bounds.height + 10,
                                      width: label.bounds.width, height: 1.0)
            bottomLine.backgroundColor = #colorLiteral(red: 0.1526089693, green: 0.164394652, blue: 0.1817740963, alpha: 1)
            label.layer.addSublayer(bottomLine)
            view.addSubview(imageView)
            view.addSubview(label)
            yCoordinate += 42
        }
    }
    
    private func addRecognizer() {
        productOneView.tag = 0
        productOneView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
        productOneView.isUserInteractionEnabled = true
        productTwoView.tag = 1
        productTwoView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
        productTwoView.isUserInteractionEnabled = true
        productThreeView.tag = 2
        productThreeView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
        productThreeView.isUserInteractionEnabled = true
    }
}
