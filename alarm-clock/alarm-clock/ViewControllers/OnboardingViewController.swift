//
//  OnboardingViewController.swift
//  alarm-clock
//
//  Created by Vinicius Emanuel on 14/04/21.
//

import UIKit

protocol OnboardingProtocol {
    func nextView(from index: OnboardingIndex)
    func ignore()
}

enum OnboardingIndex {
    case first, second, last
}

class OnboardingViewController: UIViewController {
    
    @IBOutlet weak private var nextButton: UIButton!
    @IBOutlet weak private var ignoreButton: UIButton!
    @IBOutlet weak private var descLabel: UILabel!
    
    private var textDesc: String!
    var onboardingIndex: OnboardingIndex!
    var delegate: OnboardingProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.descLabel.text = textDesc
        
        self.nextButton.isHidden = self.onboardingIndex == .last
    }
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        self.delegate?.nextView(from: self.onboardingIndex)
    }
    
    @IBAction func ignoreButtonTapped(_ sender: Any) {
        self.delegate?.ignore()
    }
    
    static func instance(description: String, onboardingIndex: OnboardingIndex) -> OnboardingViewController {
        let id = "OnboardingViewController"
        let storyboard = UIStoryboard(name: "Onboarding", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: id) as! OnboardingViewController
        viewController.textDesc = description
        viewController.onboardingIndex = onboardingIndex
        
        return viewController
    }
}

