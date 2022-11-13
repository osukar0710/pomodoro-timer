//
//  ViewController.swift
//  pomodoroTimer
//
//  Created by osukar on 2022/11/14.
//

import UIKit
import MBCircularProgressBar

class ViewController: UIViewController {

    @IBOutlet weak var progressBarView: MBCircularProgressBarView!
    @IBOutlet weak var countText: UILabel!
    
    var timer = Timer()
    var startProgressValue:Int = 0
    var maxTime:Int = 1500
    
    override func viewDidLoad() {
        super.viewDidLoad()
        progressBarView.value = 0
        progressBarView.maxValue = CGFloat(maxTime)
        
    }

    @IBAction func startButton(_ sender: UIButton) {
        timer.invalidate()
        timer = Timer.scheduledTimer(
            timeInterval: 1.0,
            target: self,
            selector: #selector(updateTimer),
            userInfo: nil,
            repeats: true
        )
    }
    
    @IBAction func stopButton(_ sender: UIButton) {
        
    }
    
    
    @IBAction func resetButton(_ sender: UIButton) {
        timer.invalidate()
        countText.text = "25:00"
        startProgressValue = 0
        progressBarView.value = 0
    }
   
    @objc func updateTimer(){
        if maxTime > 1 {
            //カウントラベル更新
            let minutesLabel:String
            let secondsLabel:String
            maxTime -= 1
            secondsLabel = String(format: "%02d", maxTime % 60)
            
            minutesLabel = String(format: "%02d", maxTime / 60)
//            print(minutesLabel)
//            print(maxTime)
            countText.text = "\(minutesLabel):\(secondsLabel)"
            //プログレスバー更新
            startProgressValue += 1
            progressBarView.value = CGFloat(startProgressValue)
        } else {
            timer.invalidate()
            countText.text = "25:00"
        }
    }
    
}

