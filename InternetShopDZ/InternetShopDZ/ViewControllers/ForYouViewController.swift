//
//  ForYouViewController.swift
//  InternetShopDZ
//
//  Created by Oleg_Yakovlev on 6.10.22.
//

import UIKit

// Экран предпочтений
final class ForYouViewController: UIViewController {
    private enum Constants {
        static let search = "Поиск"
        static let newImage = "newImage"
        static let defaultImage = "image"
        static let empty = ""
        static let forYou = "Для вас"
        static let news = "Вот что нового"
        static let productForYou = "apple-airpod"
        static let delivered = "Ваш товар отправлен."
        static let timeDelivery = "1 товар, доставка завтра"
        static let chevron = "chevron.right"
        static let statusDelivery = ("Обрабатывается", "Отправлено", "Доставлено")
        static let recommendedYou = "Рекомендуется вам"
        static let getNews = "Получайте новости о своем заказе в режиме реального времени"
        static let notifications = "Включите уведомления, чтобы получать новости о своем заказе"
        static let squareIcon = "square"
        static let yourDevices = "ваши устройства"
        static let showAll = "Показать все"
        static let fontAvenir = "Avenir Next"
        static let fontAvenirDB = "Avenir Next Demi Bold"
        static let fontArial = "Arial"
        static let fontArialDB = "Arial Hebrew Bold"
    }
    
    // MARK: - Visual Components
    private lazy var navBarImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: Constants.newImage))
        imageView.layer.cornerRadius = 25
        imageView.clipsToBounds = true
        let recognizer = UITapGestureRecognizer()
        recognizer.addTarget(self, action: #selector(chooseImageAction))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(recognizer)
        return imageView
    }()
    
    private lazy var newsLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.news
        label.textColor = .label
        label.font = UIFont(name: Constants.fontArialDB, size: 26)
        label.frame = CGRect(x: 15, y: 130, width: view.frame.width, height: 50)
        let bottomLine = CALayer()
        label.layer.addSublayer(createLine(CGRect(x: label.bounds.minX,
                                                  y: label.bounds.minY - 15,
                                                  width: label.bounds.width - 30, height: 0.3)))
        return label
    }()
    
    private lazy var productView: UIView = {
        let productView = UIView(frame: CGRect(x: 15,
                                               y: newsLabel.frame.maxY,
                                               width: view.bounds.width - 30,
                                               height: 170))
        productView.backgroundColor = .white
        productView.layer.cornerRadius = 10
        productView.layer.shadowColor = UIColor.darkGray.cgColor
        productView.layer.shadowOpacity = 1
        productView.layer.shadowRadius = 10
        productView.layer.shadowOffset = .zero
        return productView
    }()
    
    private lazy var recommendedIconImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: Constants.squareIcon))
        imageView.frame = CGRect(x: newsLabel.frame.minX + 10, y: view.frame.maxY - 220.0, width: 30, height: 30)
        imageView.tintColor = .systemRed
        return imageView
    }()
   
    // MARK: - LyfeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureStyleWhite()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        configureStyleDark()
    }
    
    // MARK: - Private Action
    @objc private func chooseImageAction() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.allowsEditing = true
        present(imagePickerController, animated: true)
    }
    
    // MARK: - Private Methods
    private func configureStyleDark() {
        overrideUserInterfaceStyle = .dark
        navigationController?.overrideUserInterfaceStyle = .dark
        tabBarController?.tabBar.backgroundColor = .systemBackground
    }
    
    private func configureStyleWhite() {
        overrideUserInterfaceStyle = .light
        tabBarController?.tabBar.backgroundColor = .systemGray
        navigationController?.overrideUserInterfaceStyle = .light
        view.backgroundColor = .systemBackground
        
    }
    
    private func configureUI() {
        configureContentNavBar()
        configureView()
    }
    
    private func configureContentNavBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.barTintColor = .label
        title = Constants.forYou
        guard let navigationBar = navigationController?.navigationBar else { return }
        navigationBar.addSubview(navBarImageView)
        navBarImageView.frame = CGRect(x: navigationBar.bounds.maxX - 70.0,
                                       y: navigationBar.bounds.maxY - 60.0,
                                       width: 50,
                                       height: 50)
        navigationBar.center.y = navigationBar.center.y
        navBarImageView.layer.cornerRadius = 25
        navBarImageView.clipsToBounds = true
        navBarImageView.image = getImage()
    }
    
    private func getImage() -> UIImage {
        guard
            let data = UserDefaults.standard.value(forKey: Constants.newImage) as? Data,
            let image = UIImage(data: data)
        else {
            let image = UIImage(named: Constants.defaultImage)
            navBarImageView.image = image
            return image ?? UIImage()
        }
        return image
    }
    
    private func configureView() {
        view.backgroundColor = .systemBackground
        view.addSubview(newsLabel)
        view.addSubview(productView)
        createDeliveryView()
        view.addSubview(createLabel(CGRect(x: productView.frame.minX,
                                           y: productView.frame.maxY + 50,
                                           width: 300,
                                           height: 30),
                                    Constants.recommendedYou,
                                    .label,
                                    UIFont(name: Constants.fontAvenirDB, size: 18) ?? UIFont(),
                                    .natural, 1))
        view.addSubview(recommendedIconImageView)
        view.addSubview(createLabel(CGRect(x: recommendedIconImageView.frame.maxX + 20,
                                           y: recommendedIconImageView.frame.minY - 10,
                                           width: 220,
                                           height: 50),
                                    Constants.getNews,
                                    .label,
                                    UIFont(name: Constants.fontAvenirDB, size: 12) ?? UIFont(),
                                    .natural, 0))
        
        view.addSubview(createLabel(CGRect(x: recommendedIconImageView.frame.maxX + 20,
                                           y: recommendedIconImageView.frame.minY + 25,
                                           width: 220,
                                           height: 50),
                                    Constants.notifications,
                                    .systemGray,
                                    UIFont(name: Constants.fontAvenirDB, size: 12) ?? UIFont(),
                                    .natural, 0))
        view.addSubview(createButton(CGRect(x: view.frame.width - 40,
                                            y: recommendedIconImageView.frame.maxY,
                                            width: 20,
                                            height: 20),
                                     Constants.chevron,
                                     .right,
                                     .clear,
                                     .systemGray,
                                     Constants.empty))
        newsLabel.layer.addSublayer(createLine(CGRect(x: view.frame.minX - 15,
                                                      y: recommendedIconImageView.frame.minY - 40,
                                                      width: view.frame.width, height: 0.3)))
        view.addSubview(createLabel(CGRect(x: productView.frame.minX,
                                           y: recommendedIconImageView.frame.maxY + 90,
                                           width: 230,
                                           height: 40),
                                    Constants.yourDevices,
                                    .label,
                                    UIFont(name: Constants.fontArialDB, size: 25) ?? UIFont(),
                                    .natural, 1))
        view.addSubview(createButton(CGRect(x: productView.frame.minX + 250,
                                            y: recommendedIconImageView.frame.maxY + 90,
                                            width: 100,
                                            height: 40),
                                     Constants.showAll,
                                     .right,
                                     .systemBlue,
                                     .clear,
                                     Constants.empty))
    }
    
    // Метод отрисовки окна информации о доставке
    private func createDeliveryView() {
        let imageView = UIImageView(frame: CGRect(x: productView.bounds.minX + 10,
                                                  y: productView.bounds.minY + 15,
                                                  width: 80,
                                                  height: 80))
        imageView.image = UIImage(named: Constants.productForYou)
        imageView.contentMode = .scaleAspectFit
        productView.addSubview(imageView)
        productView.addSubview(createLabel(CGRect(x: imageView.bounds.maxX + 10,
                                                  y: imageView.bounds.minY + 15,
                                                  width: productView.bounds.width / 2,
                                                  height: 20),
                                           Constants.delivered,
                                           .label,
                                           UIFont(name: Constants.fontAvenirDB, size: 14) ?? UIFont(),
                                           .left, 1))
        productView.addSubview(createLabel(CGRect(x: imageView.frame.maxX,
                                                  y: imageView.bounds.minY + 40,
                                                  width: productView.bounds.width / 2,
                                                  height: 20),
                                           Constants.timeDelivery,
                                           .systemGray,
                                           UIFont(name: Constants.fontAvenirDB, size: 14) ?? UIFont(),
                                           .left, 1))
        productView.addSubview(createButton(CGRect(x: productView.frame.maxX - 55,
                                                   y: imageView.bounds.minY + 40,
                                                   width: 20,
                                                   height: 20),
                                            Constants.chevron,
                                            .right,
                                            .clear,
                                            .systemGray,
                                            Constants.showAll))
        
        let progressView = UIProgressView(frame: CGRect(x: imageView.bounds.minX + 10,
                                                        y: imageView.bounds.maxY + 40,
                                                        width: productView.bounds.width - 20,
                                                        height: 10))
        progressView.transform = progressView.transform.scaledBy(x: 1, y: 2)
        progressView.layer.cornerRadius = 5
        progressView.progress = 0.5
        progressView.tintColor = .systemGray
        progressView.progressTintColor = .systemGreen
        productView.addSubview(progressView)
        
        progressView.layer.addSublayer(createLine(CGRect(x: productView.bounds.minX - 10,
                                                         y: progressView.bounds.minY - 10,
                                                         width: productView.bounds.width, height: 0.2)))
        
        productView.addSubview(createLabel(CGRect(x: progressView.frame.minX,
                                                  y: progressView.frame.maxY + 10,
                                                  width: productView.bounds.width / 3,
                                                  height: 20),
                                           Constants.statusDelivery.0,
                                           .label,
                                           UIFont(name: Constants.fontArialDB, size: 12) ?? UIFont(),
                                           .left, 1))
        productView.addSubview(createLabel(CGRect(x: progressView.frame.minX + 105,
                                                  y: progressView.frame.maxY + 10,
                                                  width: productView.bounds.width / 3,
                                                  height: 20),
                                           Constants.statusDelivery.1,
                                           .label,
                                           UIFont(name: Constants.fontArialDB, size: 12) ?? UIFont(),
                                           .center, 1))
        productView.addSubview(createLabel(CGRect(x: progressView.frame.minX + 210,
                                                  y: progressView.frame.maxY + 10,
                                                  width: productView.bounds.width / 3,
                                                  height: 20),
                                           Constants.statusDelivery.2,
                                           .systemGray,
                                           UIFont(name: Constants.fontArial, size: 12) ?? UIFont(),
                                           .right, 1))
    }
    
    // Методы создания элементов
    private func createLabel(_ frame: CGRect, _ text: String,
                             _ textColor: UIColor, _ font: UIFont,
                             _ alignment: NSTextAlignment, _ lines: Int) -> UILabel {
        let label = UILabel()
        label.frame = frame
        label.text = text
        label.numberOfLines = 0
        label.textColor = textColor
        label.font = font
        label.textAlignment = alignment
        return label
    }
    
    private func createButton(_ frame: CGRect, _ imageName: String,
                              _ allignment: UIControl.ContentHorizontalAlignment,
                              _ backgroundColor: UIColor, _ tintColor: UIColor, _ setTitle: String) -> UIButton {
        let button = UIButton()
        button.frame = frame
        button.setImage(UIImage(systemName: imageName), for: .normal)
        button.contentHorizontalAlignment = allignment
        button.tintColor = tintColor
        button.titleLabel?.font = UIFont(name: Constants.fontArial, size: 14) ?? UIFont()
        button.setTitleColor(backgroundColor, for: .normal)
        button.setTitle(Constants.showAll, for: .normal)
        return button
    }
    
    private func createLine(_ frame: CGRect) -> CALayer {
        let bottomLine = CALayer()
        bottomLine.frame = frame
        bottomLine.backgroundColor =  UIColor.lightGray.cgColor
        return bottomLine
    }
}

    // UIImagePickerControllerDelegate
extension ForYouViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        guard let newImage = info[.editedImage] as? UIImage else { return }
        navBarImageView.image = newImage
        guard let data = newImage.pngData() else { return }
        UserDefaults.standard.set(data, forKey: Constants.newImage)
        picker.dismiss(animated: true)
    }
}

    // UINavigationControllerDelegate
extension ForYouViewController: UINavigationControllerDelegate {}
