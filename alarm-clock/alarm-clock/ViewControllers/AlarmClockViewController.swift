//
//  AlarmClockViewController.swift
//  alarm-clock
//
//  Created by Vinicius Emanuel on 15/04/21.
//

import UIKit

class AlarmClockViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    static func instance() -> AlarmClockViewController {
        let id = "AlarmClockViewController"
        let storyboard = UIStoryboard(name: "AlarmClock", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: id) as! AlarmClockViewController
        return viewController
    }
}
