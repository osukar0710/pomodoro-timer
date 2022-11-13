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
    var timer = Timer()
    var startTime = 0
    var finishTime = 10

    
    override func viewDidLoad() {
        super.viewDidLoad()
        progressBarView.value = 0
        // Do any additional setup after loading the view.
    }

    @IBAction func startButton(_ sender: UIButton) {
        
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
        progressBarView.value = 0
    }
   
    @objc func updateTimer(){
        if startTime < finishTime {
            startTime += 1
            progressBarView.value = CGFloat(startTime)
        }
    }
    
}

