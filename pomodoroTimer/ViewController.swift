//
//  ViewController.swift
//  pomodoroTimer
//
//  Created by osukar on 2022/11/14.
//

import UIKit
import MBCircularProgressBar

class ViewController: UIViewController {

    @IBOutlet weak var runProgressBarView: MBCircularProgressBarView!
    @IBOutlet weak var breaktimeProgressBarView: MBCircularProgressBarView!
    @IBOutlet weak var countText: UILabel!
    @IBOutlet weak var startbuttonText: UIButton!
    
    var timer = Timer()
    var startProgressValue:Int = 0
    var maxTime:Int = 1500
    
    override func viewDidLoad() {
        super.viewDidLoad()
        runProgressBarView.value = 0
        runProgressBarView.maxValue = CGFloat(maxTime)
        
    }

    @IBAction func startButton(_ sender: UIButton) {
        startbuttonText.isHidden = true
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
        if maxTime > 1 {
            //カウントラベル更新
            let minutesLabel:String
            let secondsLabel:String
            maxTime -= 1 // 25分（1500秒から減算）
            secondsLabel = String(format: "%02d", maxTime % 60)
            minutesLabel = String(format: "%02d", maxTime / 60)

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

