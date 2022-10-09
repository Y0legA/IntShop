//
//  SelectedProductViewController.swift
//  InternetShopDZ
//
//  Created by Oleg_Yakovlev on 6.10.22.
//

import UIKit

// Экран выбранного товара
final class SelectedProductViewController: UIViewController {
    private enum Constants {
        static let iconsNavBar = ("square.and.arrow.up", "heart")
        static let color: [UIColor] = [.lightGray, .darkGray]
        static let cost = "3 990.00 руб"
        static let products = ["Чехол Incase Flat для MacBook Pro 16 дюймов":
                                ["case1", "case2", "case3"],
                               "Спортивный ремешок Black Unity для карманного":
                                ["clock1", "clock2"],
                               "Кожаный чехол Incase Flat для MacBook Pro 16 дюймов, золото":
                                ["caseBrown1", "caseBrown2", "caseBrown3"]
        ]
        static let fontAvenir = "Avenir Next"
        static let fontAvenirDB = "Avenir Next Demi Bold"
        static let fontArial = "Arial"
        static let fontArialHebrew = "Arial Hebrew"
        static let fontArialDB = "Arial Hebrew Bold"
        static let checkmark = "checkmark.circle.fill"
        static let compatible = "Cовместимо с "
        static let compatibleText = "MacBook Pro — Евгений"
        static let chooseColor = "Выбран "
        static let addBasket = "Добавить в корзину"
        static let cube = "cube.box"
        static let deliveryToday = "Заказ сегодня в течение дня, доставка:"
        static let delivery = "Чт 25 Фев - Бесплатно"
        static let variantsDelivery = "Варианты доставки для местоположения 115533"
        static let textRequests = ["Air Pods", "Apple Care", "Beats", "Сравните модели iPhone"]
    }
    
    // MARK: - Visual Components
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = productName
        label.textColor = .label
        label.font = UIFont(name: Constants.fontAvenirDB, size: 15)
        label.textAlignment = .center
        label.frame = CGRect(x: 0, y: view.frame.minY + 60, width: view.frame.width, height: 50)
        return label
    }()
    
    private lazy var costLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.text = Constants.cost
        label.font = UIFont(name: Constants.fontArial, size: 14)
        label.textColor = #colorLiteral(red: 0.4929454327, green: 0.4775297642, blue: 0.4997213483, alpha: 1)
        label.textAlignment = .center
        label.frame = CGRect(x: 0, y: nameLabel.frame.minY + 25, width: view.frame.width, height: 50)
        return label
    }()
    
    private lazy var goodsScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.frame = CGRect(x: 0,
                                  y: nameLabel.frame.minY + 90,
                                  width: view.bounds.width,
                                  height: view.frame.height / 7 * 2)
        scrollView.isPagingEnabled = true
        scrollView.indicatorStyle = .black
        
        return scrollView
    }()
    
    private lazy var nameLowLabel: UILabel = {
        let label = UILabel()
        label.text = productName
        label.textColor = .label
        label.font = UIFont(name: Constants.fontAvenir, size: 10)
        label.textColor = #colorLiteral(red: 0.4929454327, green: 0.4775297642, blue: 0.4997213483, alpha: 1)
        label.textAlignment = .center
        label.frame = CGRect(x: 0, y: goodsScrollView.frame.maxY, width: view.frame.width, height: 40)
        return label
    }()
    
    private lazy var colorContentView: UIView = {
        let contentView = UIView(frame: CGRect(x: 0, y: view.frame.maxY - 270.0,
                                               width: Double(Constants.color.count) * 70.0, height: 40.0))
        contentView.center.x = view.center.x
        return contentView
    }()
    
    private lazy var compatibleImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: Constants.checkmark))
        imageView.frame = CGRect(x: 60,
                                 y: view.frame.maxY - 200,
                                 width: 15,
                                 height: 15)
        imageView.tintColor = .green
        return imageView
    }()
    
    private lazy var compatibleLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: compatibleImageView.frame.maxX + 7,
                                          y: 0,
                                          width: 90,
                                          height: 15))
        label.center.y = compatibleImageView.center.y
        label.text = Constants.compatible
        label.font = UIFont(name: Constants.fontAvenir, size: 12)
        return label
    }()
    
    private lazy var compatibleTextLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: compatibleLabel.frame.maxX + 3,
                                          y: compatibleImageView.frame.minY,
                                          width: 200,
                                          height: compatibleLabel.frame.height))
        label.textColor = .systemBlue
        label.text = Constants.compatibleText
        label.font = UIFont(name: Constants.fontAvenir, size: 12)
        return label
    }()
    
    private lazy var addBasketButton: UIButton = {
        var button = UIButton()
        button.frame = CGRect(x: 0,
                              y: compatibleLabel.frame.maxY + 30,
                              width: view.frame.width,
                              height: 30)
        button.center.x = view.center.x
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont(name: Constants.fontArialDB, size: 13)
        button.setTitle(Constants.addBasket, for: .normal)
        button.backgroundColor = .systemBlue
        return button
    }()
    
    private lazy var cubeImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: Constants.cube))
        imageView.frame = CGRect(x: 5,
                                 y: addBasketButton.frame.maxY + 27,
                                 width: 15,
                                 height: 15)
        imageView.tintColor = .gray
        return imageView
    }()
    
    private lazy var orderTodayLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: cubeImageView.frame.maxX + 15,
                                          y: cubeImageView.frame.minY,
                                          width: view.frame.width - cubeImageView.frame.maxX + 15,
                                          height: 13))
        label.text = Constants.deliveryToday
        label.tintColor = .white
        label.font = UIFont(name: Constants.fontAvenirDB, size: 11)
        return label
    }()
    
    private lazy var dateDeliveryLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: orderTodayLabel.frame.minX,
                                          y: orderTodayLabel.frame.maxY,
                                          width: 250,
                                          height: 15))
        label.text = Constants.delivery
        label.textColor = .gray
        label.font = UIFont(name: Constants.fontAvenir, size: 12)
        return label
    }()
    
    private lazy var chooseDeliveryButton: UIButton = {
        var button = UIButton()
        button.frame = CGRect(x: dateDeliveryLabel.frame.minX,
                              y: dateDeliveryLabel.frame.maxY,
                              width: 275,
                              height: compatibleLabel.frame.height)
        button.setTitle(Constants.variantsDelivery, for: .normal)
        button.titleLabel?.font = UIFont(name: Constants.fontArial, size: 12)
        button.setTitleColor(.systemBlue, for: .normal)
        
        return button
    }()
    
    // MARK: - Public Properties
    var productName = String()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Private Actions
    @objc private func chooseColorButtonAction(_ sender: UIButton) {
        colorContentView.subviews[sender.tag * 2].isHidden.toggle()
    }
    
    // MARK: - Private Methods
    private func configureUI() {
        configureNavBar()
        configureView()
        makeImagesForScrollView()
        createProductColorButton()
        createWhiteLine()
    }
    
    private func createProductColorButton() {
        var xCoordinate = 30
        for (index, color) in Constants.color.enumerated() {
            let size = CGSize(width: 30, height: 30)
            let button = UIButton(frame: CGRect(origin: CGPoint(x: xCoordinate, y: 0), size: size))
            button.backgroundColor = color
            button.layer.cornerRadius = 15
            button.tag = index
            button.addTarget(self, action: #selector(chooseColorButtonAction), for: .touchUpInside)
            let borderView = UIView(frame: CGRect(x: button.frame.minX - 3.0,
                                                  y: button.frame.minY - 3.0,
                                                  width: button.frame.width + 6.0,
                                                  height: button.frame.height + 6.0))
            borderView.layer.cornerRadius = 17
            borderView.layer.borderWidth = 1
            borderView.layer.borderColor =  UIColor.systemBlue.cgColor
            borderView.tag = index
            borderView.isHidden = true
            borderView.isUserInteractionEnabled = false
            colorContentView.addSubview(borderView)
            colorContentView.addSubview(button)
            xCoordinate += 40
        }
        view.addSubview(colorContentView)
    }
    
    private func configureView() {
        view.backgroundColor = .systemBackground
        view.addSubview(nameLabel)
        view.addSubview(goodsScrollView)
        view.addSubview(costLabel)
        view.addSubview(nameLowLabel)
        view.addSubview(compatibleImageView)
        view.addSubview(compatibleLabel)
        view.addSubview(compatibleTextLabel)
        view.addSubview(addBasketButton)
        view.addSubview(cubeImageView)
        view.addSubview(orderTodayLabel)
        view.addSubview(dateDeliveryLabel)
        view.addSubview(chooseDeliveryButton)
    }
    
    private func configureNavBar() {
        let rightFavoriteButton = UIBarButtonItem(customView:
                                                    UIImageView(image: UIImage(systemName: Constants.iconsNavBar.0)))
        let rightHeartButton = UIBarButtonItem(customView:
                                                UIImageView(image: UIImage(systemName: Constants.iconsNavBar.1)))
        navigationItem.rightBarButtonItems = [rightHeartButton, rightFavoriteButton]
    }
    
    private func makeImagesForScrollView() {
        guard let products = Constants.products[productName] else { return }
        var imageViewCoordinate = goodsScrollView.bounds.origin
        for productName in products {
            let imageView = UIImageView(frame: CGRect(x: 0,
                                                      y: imageViewCoordinate.y,
                                                      width: view.frame.width - 160,
                                                      height: view.frame.height / 4))
            imageView.center.x = view.center.x + imageViewCoordinate.x
            
            let image = UIImage(named: productName)
            
            imageView.image = image
            imageView.contentMode = .scaleAspectFit
            goodsScrollView.addSubview(imageView)
            imageViewCoordinate.x += view.frame.width
        }
        goodsScrollView.contentSize = CGSize(width: imageViewCoordinate.x, height: view.frame.height / 4)
    }
    
    private func createWhiteLine() {
        let view = UIView(frame: CGRect(origin: CGPoint(x: goodsScrollView.bounds.minX + 10,
                                                        y: goodsScrollView.bounds.maxY - 6),
                                        size: CGSize(width: goodsScrollView.contentSize.width - 20, height: 2)))
        view.backgroundColor = .label
        view.alpha = 0.5
        goodsScrollView.addSubview(view)
    }
    
}
