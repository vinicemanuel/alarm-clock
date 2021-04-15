//
//  PageViewController.swift
//  alarm-clock
//
//  Created by Vinicius Emanuel on 14/04/21.
//

import UIKit

class PageViewController: UIPageViewController {
    
    var onboardingviewControllers: [OnboardingViewController] = []
    
    private var currentIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        self.dataSource = self
        
        let pageControl = UIPageControl.appearance()
        pageControl.currentPageIndicatorTintColor = .black
        pageControl.pageIndicatorTintColor = .gray
        
        self.onboardingviewControllers.append(OnboardingViewController.instance(description: "Descrição da funcionalidade de configuração de diferentes tempos.", onboardingIndex: .first))
        self.onboardingviewControllers.append(OnboardingViewController.instance(description: "Descrição da funcionalidade de contagem regressiva.", onboardingIndex: .second))
        self.onboardingviewControllers.append(OnboardingViewController.instance(description: "Descrição da funcionalidade de notificação.", onboardingIndex: .last))
        
        self.onboardingviewControllers.forEach({$0.delegate = self})
        
        self.setViewControllers([self.onboardingviewControllers[0]], direction: .forward, animated: true, completion: nil)
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return self.currentIndex
    }
    
    static func instance() -> UIViewController {
        let id = "RootViewController"
        let storyboard = UIStoryboard(name: "Onboarding", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: id)
        return viewController
    }
}

extension PageViewController: OnboardingProtocol {
    func nextView(from index: OnboardingIndex) {
        
        switch index {
        case .first:
            self.currentIndex = 1
            self.setViewControllers([self.onboardingviewControllers[1]], direction: .forward, animated: true, completion: nil)
        case .second:
            self.currentIndex = 2
            self.setViewControllers([self.onboardingviewControllers[2]], direction: .forward, animated: true, completion: nil)
        default:
            self.ignore()
        }
    }
    
    func ignore() {
        UserDefaults.standard.setValue(true, forKey: "onboarding_showed")
        guard let window = self.view.window else { return }
        let viewController = UIViewController()
        viewController.view.backgroundColor = .red
        window.rootViewController = viewController
        let options: UIView.AnimationOptions = .transitionFlipFromRight
        UIView.transition(with: window, duration: 0.3, options: options, animations: {}, completion: nil)
    }
}

extension PageViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = self.onboardingviewControllers.firstIndex(of: viewController as! OnboardingViewController) else {
            return nil
        }
        let previousIndex = viewControllerIndex - 1
        if previousIndex < 0 {
            return nil
        }
        
        if self.onboardingviewControllers.count < previousIndex {
            return nil
        }
        
        return onboardingviewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = self.onboardingviewControllers.firstIndex(of: viewController as! OnboardingViewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        
        if self.onboardingviewControllers.count == nextIndex {
            return nil
        }
        
        if self.onboardingviewControllers.count < nextIndex {
            return nil
        }
        
        return self.onboardingviewControllers[nextIndex]
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return self.onboardingviewControllers.count
    }
}
