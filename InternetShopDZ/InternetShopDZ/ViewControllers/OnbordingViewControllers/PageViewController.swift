//
//  PageViewController.swift
//  InternetShopDZ
//
//  Created by Oleg_Yakovlev on 12.10.22.
//

import UIKit

// Экран онбординга
final class PageViewController: UIPageViewController {
    private enum Constants {
        // swiftlint:disable all
        static let pages = [("page1", "Track Your Cycle", "Manage irregular period and learn how to improve your period"),
                            ("page2", "Daily Health Insight", "Personal health inaight. Vestibulum runrum quam vitae tingludient"),
                            ("page3", "Plan Your Pregnancy", "Favorable days are impornant. Vestibulum runrum quam vitae tingludient")]
        // swiftlint:enable all
        static let skip = "SKIP"
        static let next = "NEXT"
        static let getStarted = "GET STARTED!"
        static let newKey = "didShow"
        static let boolRecall = "true"
        static let fontAvenir = "Avenir Next"
        static let fontAvenirDB = "Avenir Next Demi Bold"
        static let fontArial = "Arial"
        static let fontArialDB = "Arial Hebrew Bold"
    }
    
    // MARK: - Visual Components
    private let skipButton = UIButton()
    private let nextButton = UIButton()
    private let getStartedButton = UIButton()
    private let pageControl = UIPageControl()
    private var pages: [UIViewController] = []
    
    // MARK: - Private Properties
    private let initialPage = 0
    
    // MARK: - Initializers
    override init(transitionStyle style: UIPageViewController.TransitionStyle,
                  navigationOrientation: UIPageViewController.NavigationOrientation,
                  options: [UIPageViewController.OptionsKey: Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: navigationOrientation)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configurePageControll()
        configureView()
        configureUIElements()
    }
    
    // MARK: - Private Action
    @objc private func pageControlTappedAction(_ sender: UIPageControl) {
        setViewControllers([pages[sender.currentPage]], direction: .forward, animated: true)
    }
    
    @objc private func goNextPageAction() {
        guard let pageControl = view.subviews.first(where: { $0 is UIPageControl }) as? UIPageControl else { return }
        pageControl.currentPage += 1
        goForward()
        setIsHiddenButtons(pageControl.currentPage == pages.count - 1)
    }
    
    @objc private func goOutAction() {
        let viewController = TabBarViewController()
        viewController.modalPresentationStyle = .fullScreen
        present(viewController, animated: true)
        let userDefaults = UserDefaults.standard
        userDefaults.set(Constants.boolRecall, forKey: Constants.newKey)
    }
    
    // MARK: - Private Methods
    private func configurePageControll() {
        dataSource = self
        delegate = self
        pageControl.addTarget(self, action: #selector(pageControlTappedAction), for: .valueChanged)
        Constants.pages.forEach { page in
            let viewController = OnboardingViewController(imageName: page.0, title: page.1, text: page.2)
            pages.append(viewController)
        }
        setViewControllers([pages[initialPage]], direction: .forward, animated: true)
    }
    
    private func configureUIElements() {
       configurePageControl()
        configureSkipButton()
        configureNextButton()
        configureGetStartedButton()
    }
    
    private func configureView() {
        overrideUserInterfaceStyle = .light
        view.addSubview(pageControl)
        view.addSubview(nextButton)
        view.addSubview(skipButton)
        view.addSubview(getStartedButton)
    }
    
    private func configurePageControl() {
        pageControl.frame = CGRect(x: 0, y: view.bounds.maxY - 40, width: 200, height: 20)
        pageControl.center.x = view.center.x
        pageControl.currentPageIndicatorTintColor = .systemBlue
        pageControl.pageIndicatorTintColor = .systemGray2
        pageControl.numberOfPages = pages.count
        pageControl.currentPage = initialPage
    }
    
    private func configureSkipButton() {
        skipButton.frame = CGRect(x: 50, y: view.bounds.maxY - 40, width: 50, height: 20)
        skipButton.setTitleColor(.lightGray, for: .normal)
        skipButton.setTitle(Constants.skip, for: .normal)
        skipButton.addTarget(self, action: #selector(goOutAction), for: .primaryActionTriggered)
    }
    
    private func configureNextButton() {
        nextButton.frame = CGRect(x: 280, y: view.bounds.maxY - 40, width: 50, height: 20)
        nextButton.setTitleColor(.systemBlue, for: .normal)
        nextButton.setTitle(Constants.next, for: .normal)
        nextButton.addTarget(self, action: #selector(goNextPageAction), for: .primaryActionTriggered)
    }
    
    private func configureGetStartedButton() {
        getStartedButton.frame = CGRect(x: 0, y: view.bounds.maxY - 40, width: 200, height: 20)
        getStartedButton.center.x = view.center.x
        getStartedButton.setTitleColor(.systemBlue, for: .normal)
        getStartedButton.setTitle(Constants.getStarted, for: .normal)
        getStartedButton.isHidden = true
        getStartedButton.addTarget(self, action: #selector(goOutAction), for: .primaryActionTriggered)
    }
    
    private func setIsHiddenButtons(_ isHidden: Bool) {
        guard let pageControl = view.subviews.first(where: { $0 is UIPageControl }) as? UIPageControl else { return }
        pageControl.isHidden = isHidden
        nextButton.isHidden = isHidden
        skipButton.isHidden = isHidden
        getStartedButton.isHidden = !isHidden
    }
    
    private func goForward() {
        guard let currentPage = viewControllers?.first else { return }
        guard let nextPage = dataSource?.pageViewController(self, viewControllerAfter: currentPage) else { return }
        setViewControllers([nextPage], direction: .forward, animated: true)
    }
    
    private func goBack() {
        guard let currentPage = viewControllers?.first else { return }
        guard let prevPage = dataSource?.pageViewController(self, viewControllerBefore: currentPage) else { return }
        setViewControllers([prevPage], direction: .forward, animated: true)
    }
}

// MARK: - UIPageViewControllerDataSource
extension PageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: viewController) else { return nil }
        guard currentIndex == 0 else { return pages[currentIndex - 1] }
        return pages.last
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: viewController),
        currentIndex < pages.count - 1 else { return pages.first }
        return pages[currentIndex + 1]
    }
}

// MARK: - UIPageViewControllerDelegate
extension PageViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController,
                            didFinishAnimating finished: Bool,
                            previousViewControllers: [UIViewController],
                            transitionCompleted completed: Bool) {
        guard let viewController = pageViewController.viewControllers?.first,
        let currentIndex = pages.firstIndex(of: viewController) else { return }
        pageControl.currentPage = currentIndex
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            willTransitionTo pendingViewControllers: [UIViewController]) {
        guard let viewController = pendingViewControllers.first,
              viewController is OnboardingViewController else { return }
        setIsHiddenButtons(viewController === pages.last)
    }
}

