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
    
    private let options = ["--", "5 segundos" ,"10 segundos", "15 segundos", "20 segundos"]
    private var interval: Int = 0
    private var timerStaterd = false
    private var timer: Timer?
    
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
        if self.interval == 0 { return }
        self.timerStaterd.toggle()

        if self.timerStaterd {
            self.startAlarm()
        } else {
            self.stopAlarm()
        }
    }
    
    private func startAlarm() {
        UserNotificationHelper.shared.askForPermission { (granted) in
            if granted {
                UserNotificationHelper.shared.sendNotificationWith(interval: self.interval)
                DispatchQueue.main.async {
                    self.startTimerInterval()
                    self.showTimer(started: self.timerStaterd)
                }
            }
        }
    }
    
    private func stopAlarm() {
        self.stopTimeInterval()
        self.showTimer(started: self.timerStaterd)
        UserNotificationHelper.shared.disableNotification()
    }
    
    private func stopTimeInterval() {
        self.timer?.invalidate()
        self.timerLabel.text = "00:00"
        self.interval = 0
        self.pickerView.selectRow(0, inComponent: 0, animated: false)
    }
    
    private func startTimerInterval() {
        if self.interval == 0 { return }
        
        self.timer = Timer(fire: Date(), interval: 1, repeats: true, block: { [unowned self] (_) in
            
            if self.interval  == 0 {
                self.timer?.invalidate()
                self.timerLabel.text = "00:00"
            } else {
                self.timerLabel.text = self.interval < 10 ? "00:0\(self.interval)" : "00:\(self.interval)"
            }
            
            self.interval -= 1
        })
        if let timer = self.timer {
            RunLoop.current.add(timer, forMode: .common)
        }
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
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.interval = row * 5
    }
}

