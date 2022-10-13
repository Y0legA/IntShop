//
//  OnboardingViewController.swift
//  InternetShopDZ
//
//  Created by Oleg_Yakovlev on 12.10.22.
//

import UIKit

// Экран выбранного контроллера
final class OnboardingViewController: UIViewController {
    private enum Constants {
        static let fontAvenir = "Avenir Next"
        static let fontHoefler = "Hoefler Text Black"
    }
    
    // MARK: - Visual Components
    private let backgroundImageView = UIImageView()
    private let titleTextLabel = UILabel()
    private let textLabel = UILabel()
   
    // MARK: - Initializers
    init(imageName: String, title: String, text: String) {
        super.init(nibName: nil, bundle: nil)
        backgroundImageView.image = UIImage(named: imageName)
        titleTextLabel.text = title
        textLabel.text = text
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UILabel.animate(withDuration: 2) {
            self.textLabel.alpha = 1
            self.titleTextLabel.alpha = 1
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.textLabel.alpha = 0
        self.titleTextLabel.alpha = 0
    }
    
    // MARK: - Private Properties
    private func configureUI() {
        configureView()
        configureElements()
    }
    
    private func configureView() {
        view.backgroundColor = .systemBackground
        view.addSubview(backgroundImageView)
        view.addSubview(titleTextLabel)
        view.addSubview(textLabel)
    }
    
    private func configureElements() {
        backgroundImageView.frame = CGRect(origin: .zero,
                                           size: CGSize(width: view.bounds.width,
                                                        height: view.bounds.height / 3 * 2))
        backgroundImageView.contentMode = .scaleAspectFit
        
        titleTextLabel.frame = CGRect(x: 0, y: view.frame.midY + 100, width: view.bounds.width, height: 40)
        titleTextLabel.font = UIFont(name: Constants.fontAvenir, size: 25)
        titleTextLabel.textAlignment = .center
        titleTextLabel.alpha = 0
        
        textLabel.frame = CGRect(x: 0, y: titleTextLabel.frame.maxY, width: view.bounds.width - 60, height: 60)
        textLabel.center.x = view.center.x
        textLabel.font = UIFont(name: Constants.fontHoefler, size: 13)
        textLabel.textAlignment = .center
        textLabel.textColor = .darkGray
        textLabel.numberOfLines = 0
        textLabel.alpha = 0
    }
}
