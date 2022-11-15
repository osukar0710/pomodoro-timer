//
//  ViewController.swift
//  pomodoroTimer
//
//  Created by osukar on 2022/11/14.
//

import UIKit
import MBCircularProgressBar

class ViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var pomodoroCounterLabel: UILabel!
    
    @IBOutlet weak var runProgressBarView: MBCircularProgressBarView!
    @IBOutlet weak var countText: UILabel!
    @IBOutlet weak var startbuttonText: UIButton!
    
    var timer = Timer()
    var startProgressValue:Int = 0
    var concentrationTime:Int = 1500
    var breakTime:Int = 300
    var openingTitleLabel = "PomodoroTimer"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        runProgressBarView.value = 0
        runProgressBarView.maxValue = CGFloat(concentrationTime)
        
    }

    @IBAction func startButton(_ sender: UIButton) {
        startbuttonText.isHidden = true
        titleLabel.text = "集中モード"
        timer = Timer.scheduledTimer(
            timeInterval: 1.0,
            target: self,
            selector: #selector(updateTimer),
            userInfo: nil,
            repeats: true
        )
    }
    
    @IBAction func stopButton(_ sender: UIButton) {
        startbuttonText.isHidden = false
        timer.invalidate()
    }
    
    @IBAction func resetButton(_ sender: UIButton) {
        startbuttonText.isHidden = false
        timer.invalidate()
        countText.text = "25:00"
        startProgressValue = 0
        runProgressBarView.value = 0
    }
   
    @objc func updateTimer(){
        if concentrationTime > 1 {
            //カウントラベル更新
            let minutesLabel:String
            let secondsLabel:String
            concentrationTime -= 1 // 25分（1500秒から減算）
            secondsLabel = String(format: "%02d", concentrationTime % 60)
            minutesLabel = String(format: "%02d", concentrationTime / 60)

            countText.text = "\(minutesLabel):\(secondsLabel)"
            //プログレスバー更新
            startProgressValue += 1
            runProgressBarView.value = CGFloat(startProgressValue)
        } else {
            timer.invalidate()
            countText.text = "25:00"
        }
    }
    
}

