//
//  DetailsViewController.swift
//  InternetShopDZ
//
//  Created by Oleg_Yakovlev on 10.10.22.
//

import UIKit
import WebKit

// Экран товара на сайте магазина
final class DetailsViewController: UIViewController {
    // MARK: - Visual Components
    private lazy var webView: WKWebView = {
        let webWiew = WKWebView(frame: CGRect(origin: .zero, size: view.bounds.size))
        return webWiew
    }()
    
    // MARK: - Public Properties
    var productName = String()
    var extention = String()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        openPdfAction()
    }
    
    // MARK: - Private Actions
    @objc private func openPdfAction() {
        guard let filePath = Bundle.main.url(forResource: productName, withExtension: extention) else { return }
        let request = URLRequest(url: filePath)
        webView.load(request)
    }
    
    // MARK: - Private Methods
    private func configureUI() {
        view.addSubview(webView)
    }
}
