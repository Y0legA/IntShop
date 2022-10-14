//
//  ShowProductAppleStoreViewController.swift
//  InternetShopDZ
//
//  Created by Oleg_Yakovlev on 10.10.22.
//

import UIKit
import WebKit

// Экран товара на сайте магазина
final class WebProductViewController: UIViewController {
    private enum Constants {
        // swiftlint:disable all
        static let products = ["Чехол Incase Flat для MacBook Pro 16 дюймов" : "https://www.apple.com/shop/product/HQ292ZM/A/incase-compact-sleeve-in-flight-nylon-for-16-macbook-pro?fnode=d32412dff85657faf4630eccb715c8acc14f3affc9faca310ec5e340862da282c96ee9a4339a01f3a0daa2ce783941750f93bbe8ee388fb030c6b7191dabc64946dee81be77cfb0a07fc9399856fe41ed0bbf4b98c2b464f38a0b0811ac7a13e",
                               "Спортивный ремешок Black Unity для корпуса 44мм) размер R": "https://www.apple.com/shop/product/MJ4W3AM/A/44mm-black-unity-sport-band-regular?fnode=1ee9ae56cb62a903af728660e12167665581f5eab0295881f54c1cee789517557b8f552f61215ce4edc5fae5af99c277202930b78547ba2c5bbd48ed4a2ed8eee794d1e1333498dd61ad0f8b31e3693295134b448ca0a49f347c90b449a0e460",
                               "Кожаный чехол Incase Flat для MacBook Pro 16 дюймов, золото": "https://www.apple.com/shop/product/HP9E2ZM/A/incase-13-icon-sleeve-with-woolenex-for-macbook-air-and-macbook-pro?fnode=d32412dff85657faf4630eccb715c8acc14f3affc9faca310ec5e340862da282c96ee9a4339a01f3a0daa2ce783941750f93bbe8ee388fb030c6b7191dabc64946dee81be77cfb0a07fc9399856fe41ed0bbf4b98c2b464f38a0b0811ac7a13e",
                               "Apple iPhone 14 ProMax in graphite":
                                "https://www.apple.com/iphone-14-pro/"
        ]
        // swiftlint:enable all
        static let leftIcon = "chevron.left"
        static let rightIcon = "chevron.right"
        static let refreshIcon = "arrow.clockwise"
        static let shareIcon = "square.and.arrow.up"
    }
    
    // MARK: - Visual Components
    private lazy var webView: WKWebView = {
        let webWiew = WKWebView(frame: CGRect(origin: CGPoint(x: view.bounds.minX, y: 30), size: view.bounds.size))
        return webWiew
    }()
    
    private lazy var backBarItem: UIBarButtonItem = {
        let barItem = UIBarButtonItem()
        backBarItem.isEnabled = webView.canGoBack
        return barItem
    }()
    
    private lazy var forwardBarItem: UIBarButtonItem = {
        let barItem = UIBarButtonItem()
        forwardBarItem.isEnabled = webView.canGoForward
        return barItem
    }()
    
    private lazy var progressView: UIProgressView = {
        let progressView = UIProgressView()
        progressView.frame = CGRect(x: 0, y: webView.bounds.maxY - 60, width: 180, height: 30)
        progressView.center.x = view.center.x
        progressView.progressTintColor = .systemCyan
        progressView.tintColor = .systemBackground
        return progressView
    }()
    
    // MARK: - Public Properties
    var productName = String()
    
    // MARK: - Private Properties
    private var currentUrl: URL?
    private var observation: NSKeyValueObservation?
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Private Actions
    @objc private func goBackAction() {
        guard webView.canGoBack else { return }
        webView.goBack()
    }
    
    @objc private func goForwardAction() {
        guard webView.canGoForward else { return }
        webView.goForward()
    }
    
    @objc private func shareAction() {
        if let sharingStringUrl = currentUrl?.absoluteString {
            let sharingController = UIActivityViewController(activityItems: [sharingStringUrl],
                                                             applicationActivities: nil)
            present(sharingController, animated: true, completion: nil)
        }
    }
    
    @objc private func refreshPageAction() {
        webView.reload()
    }
    
    // MARK: - Private Methods
    private func configureUI() {
        configureView()
        createToolBar()
        configureWebView()
    }
    
    private func configureView() {
        view.backgroundColor = .systemBackground
        view.addSubview(webView)
        view.addSubview(progressView)
    }
    
    private func createToolBar() {
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: view.frame.maxY - 110, width: view.bounds.width, height: 40))
        backBarItem = UIBarButtonItem(image: UIImage(systemName: Constants.leftIcon),
                                      style: .plain, target: self, action: #selector(goBackAction))
        forwardBarItem = UIBarButtonItem(image: UIImage(systemName: Constants.rightIcon),
                                         style: .plain, target: self, action: #selector(goForwardAction))
        let refreshItem = UIBarButtonItem(image: UIImage(systemName: Constants.refreshIcon),
                                          style: .plain, target: self, action: #selector(refreshPageAction))
        let shareItem = UIBarButtonItem(image: UIImage(systemName: Constants.shareIcon),
                                        style: .plain, target: self, action: #selector(shareAction))
        let flexibleSpaceItem = UIBarButtonItem(systemItem: .flexibleSpace)
        toolBar.items = [backBarItem, forwardBarItem, flexibleSpaceItem, shareItem, refreshItem]
        toolBar.isTranslucent = false
        toolBar.barTintColor = .systemBackground
        webView.addSubview(toolBar)
    }
    
    private func selectActionNavigationItems() {
        backBarItem.isEnabled = webView.canGoBack
        forwardBarItem.isEnabled = webView.canGoForward
    }
    
    private func configureWebView() {
        webView.navigationDelegate = self
        guard let stringUrl = Constants.products[productName] else { return }
        let url = URL(string: stringUrl)
        currentUrl = url
        guard let url = url else { return }
        let request = URLRequest(url: url)
        webView.load(request)
        observation = webView.observe(
            \.estimatedProgress,
             options: [.new],
             changeHandler: { [weak self] webView, _ in
                 guard let self = self else { return }
                 self.progressView.progress = Float(webView.estimatedProgress * 2)
                 return
             })
    }
}

// MARK: - WKNavigationDelegate
extension WebProductViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        progressView.isHidden = true
        selectActionNavigationItems()
        currentUrl = webView.url
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        progressView.isHidden = false
        selectActionNavigationItems()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        selectActionNavigationItems()
    }
}
