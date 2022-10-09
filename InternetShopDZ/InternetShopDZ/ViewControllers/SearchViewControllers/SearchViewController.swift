//
//  SearchViewController.swift
//  InternetShopDZ
//
//  Created by Oleg_Yakovlev on 5.10.22.
//

import UIKit

// Экран поиска
final class SearchViewController: UIViewController {
    private enum Constants {
        static let search = "Поиск"
        static let products = [("Чехол Incase Flat для MacBook Pro 16 дюймов", "case1"),
                               ("Спортивный ремешок Black Unity для карманного", "clock1"),
                               ("Кожаный чехол Incase Flat для MacBook Pro 16 дюймов, золото", "caseBrown1")
        ]
        static let seed = "Недавно просмотренные"
        static let searchIcon = "magnifyingglass"
        static let clear = "Очистить"
        static let fontAvenir = "Avenir Next"
        static let fontAvenirDB = "Avenir Next Demi Bold"
        static let fontArial = "Arial"
        static let fontArialHebrew = "Arial Hebrew"
        static let fontArialDB = "Arial Hebrew Bold"
        static let requests = "Варианты запросов"
        static let placeholder = "Поиск по продуктам и магазинам"
        static let textRequests = ["Air Pods", "Apple Care", "Beats", "Сравните модели iPhone"]
    }
    
    // MARK: - Visual Properties
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.search
        label.textColor = .label
        label.font = UIFont(name: Constants.fontAvenirDB, size: 25)
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
        label.font = UIFont(name: Constants.fontAvenirDB, size: 17)
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
        button.setTitle(Constants.clear, for: .normal)
        button.contentHorizontalAlignment = .right
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        button.addTarget(self, action: #selector(clearSearchTextFieldAction), for: .touchDown)
        return button
    }()
    
    private lazy var goodsScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.frame = CGRect(x: 0, y: clearButton.frame.maxY + 15, width: view.bounds.width, height: 150)
        return scrollView
    }()
    
    private lazy var requestsLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.requests
        label.textColor = .label
        label.font = UIFont(name: Constants.fontAvenirDB, size: 18)
        label.frame = CGRect(x: 0, y: goodsScrollView.frame.maxY + 20, width: view.frame.width, height: 50)
        return label
    }()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Private Actions
    @objc private func clearSearchTextFieldAction() {
        productsSearchBar.text = String()
    }
    
    @objc private func handleTap(_ recognizer: UIGestureRecognizer) {
        let selectVC = SelectedProductViewController()
        let barButtonItem = UIBarButtonItem()
        barButtonItem.title = Constants.search
        navigationItem.backBarButtonItem = barButtonItem
        selectVC.productName = Constants.products[recognizer.view?.tag ?? 0].0
        navigationController?.pushViewController(selectVC, animated: true)
    }
    
    // MARK: - Private Methods
    private func configureUI() {
        makeImagesForScrollView()
        configureView()
        makeRequestsLabel()
    }
    
    private func configureView() {
        view.backgroundColor = .systemBackground
        view.addSubview(titleLabel)
        view.addSubview(productsSearchBar)
        view.addSubview(viewedLabel)
        view.addSubview(clearButton)
        view.addSubview(goodsScrollView)
        view.addSubview(requestsLabel)
    }
    
    private func makeImagesForScrollView() {
        var products: [Product] = []
        Constants.products.forEach {
            products.append(Product(parameter: ProductInfo(productName: $0.0, productImageName: $0.1)))
        }
        var xCoord = goodsScrollView.frame.minX
        for (index, item) in products.enumerated() {
            item.frame = CGRect(x: xCoord, y: 0, width: 140, height: 150)
            item.tag = index
            let recognizer = UITapGestureRecognizer()
            recognizer.addTarget(self, action: #selector(handleTap))
            item.addGestureRecognizer(recognizer)
            goodsScrollView.addSubview(item)
            xCoord += 135
        }
        goodsScrollView.contentSize = CGSize(width: xCoord, height: 150)
    }
    
    private func makeRequestsLabel() {
        var yCoordinate: CGFloat = requestsLabel.frame.maxY + 8
        for textRequest in Constants.textRequests {
            let imageView = UIImageView(image: UIImage(systemName: Constants.search))
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
}
