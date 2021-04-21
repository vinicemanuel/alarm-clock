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
    
    let options = ["5 segundos" ,"10 segundos", "15 segundos", "20 segundos"]
    
    var timerStaterd = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.pickerView.delegate = self
        self.pickerView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.showTimer(started: self.timerStaterd)
        self.showClockImage(size: self.view.frame.size)
    }

    static func instance() -> AlarmClockViewController {
        let id = "AlarmClockViewController"
        let storyboard = UIStoryboard(name: "AlarmClock", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: id) as! AlarmClockViewController
        return viewController
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        self.showClockImage(size: size)
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        self.timerStaterd.toggle()
        self.showTimer(started: self.timerStaterd)
    }
    
    private func showClockImage(size: CGSize) {
        if size.width > size.height {
            self.clockImage.image = #imageLiteral(resourceName: "digital")
        } else {
            self.clockImage.image = #imageLiteral(resourceName: "analogico")
        }
    }
    
    private func showTimer(started: Bool) {
        self.timerLabel.isHidden = !started
        self.pickerView.isHidden = started
        
        let buttonTitle = started ? "Cancel" : "Start"
        self.timerButton.setTitle(buttonTitle, for: .normal)
    }
}

extension AlarmClockViewController: UIPickerViewDelegate, UIPickerViewDataSource {
   
    func numberOfComponents(in pickerView: UIPickerView) -> Int { 1 }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int { self.options.count }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? { self.options[row] }
}

