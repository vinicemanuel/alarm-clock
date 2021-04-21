//
//  AlarmClockViewController.swift
//  alarm-clock
//
//  Created by Vinicius Emanuel on 15/04/21.
//

import UIKit

class AlarmClockViewController: UIViewController {

    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var clockImage: UIImageView!
    @IBOutlet weak var timerButton: UIButton!
    
    var timerStaterd = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.showTimer(started: self.timerStaterd)
    }

    static func instance() -> AlarmClockViewController {
        let id = "AlarmClockViewController"
        let storyboard = UIStoryboard(name: "AlarmClock", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: id) as! AlarmClockViewController
        return viewController
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        if size.width > size.height {
            self.clockImage.image = #imageLiteral(resourceName: "digital")
        } else {
            self.clockImage.image = #imageLiteral(resourceName: "analogico")
        }
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        self.timerStaterd.toggle()
        self.showTimer(started: self.timerStaterd)
    }
    
    private func showTimer(started: Bool) {
        self.timerLabel.isHidden = !started
        self.pickerView.isHidden = started
        
        let buttonTitle = started ? "Cancel" : "Start"
        self.timerButton.setTitle(buttonTitle, for: .normal)
    }
}

