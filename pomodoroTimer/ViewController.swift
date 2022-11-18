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
    @IBOutlet weak var timerTextLabel: UILabel!
    @IBOutlet weak var startbuttonText: UIButton!
    
    var timer = Timer()
    var startProgressValue: Int = 0//プログレスバー開始値
    var maxTime: Int = 1500// 修正　Max Timeへ　別で集中タイム変数作成
    var concentrateTime: Int = 3//集中する時間設定
    var breakTime: Int = 3//休憩する時間設定
    var loopCounter: Int = 0
    var openingTitleLabel:String = "PomodoroTimer"
    var modeSet: String = "concentrate"
    
    override func viewDidLoad() {
        setupObserver()
        super.viewDidLoad()
        //初期値セット
        titleLabel.text = openingTitleLabel
        maxTime = concentrateTime
        runProgressBarView.value = 0
//        runProgressBarView.maxValue = CGFloat(concentrationTime)
        runProgressBarView.maxValue = CGFloat(maxTime)//プログレスバー最大値
    }

    @IBAction func startButton(_ sender: UIButton) {
        startbuttonText.isHidden = true
        titleLabel.text = "集中モード"
        timerRun()
    }
    
    @IBAction func stopButton(_ sender: UIButton) {
        startbuttonText.isHidden = false
        timer.invalidate()
    }
    
    @IBAction func resetButton(_ sender: UIButton) {
        startbuttonText.isHidden = false
        timer.invalidate()
        //タイマーリセット
        timerTextLabel.text = "25:00"
        //タイトルリセット
        titleLabel.text = openingTitleLabel
        //プログレスバーリセット
        startProgressValue = 0
        runProgressBarView.value = 0
        maxTime = 3
        //ループカウンターリセット
        loopCounter = 0
        pomodoroCounterLabel.text = "\(loopCounter)/4"
        
        runProgressBarView.maxValue = CGFloat(maxTime)
//        NotificationCenter.default.removeObserver(self)
    }
    
    func timerRun() {
        timer = Timer.scheduledTimer(
            timeInterval: 1.0,
            target: self,
            selector: #selector(updateTimer),
            userInfo: nil,
            repeats: true
        )
    }
    
    func concentrateModeSet(){
        titleLabel.text = "集中モード"
        timerTextLabel.text = "25:00"
        maxTime = concentrateTime
        runProgressBarView.value = 0
        runProgressBarView.maxValue = CGFloat(concentrateTime)
    }

    func breakModeSet() {
        titleLabel.text = "休憩中"
        timerTextLabel.text = "5:00"
        maxTime = breakTime
        runProgressBarView.value = 0
        runProgressBarView.maxValue = CGFloat(breakTime)
        
    }
   
    @objc func updateTimer(){

        if maxTime >= 1 {
            //カウントラベル更新
            let minutesLabel:String
            let secondsLabel:String
            maxTime -= 1 // 25分（1500秒から減算）
            secondsLabel = String(format: "%02d", maxTime % 60)
            minutesLabel = String(format: "%02d", maxTime / 60)
            timerTextLabel.text = "\(minutesLabel):\(secondsLabel)"
            //プログレスバー更新
            startProgressValue += 1
            runProgressBarView.value = CGFloat(startProgressValue)
        } else {

            timer.invalidate()//タイマー停止
            //集中モード⇨休憩モード変更
            NotificationCenter.default.post(
                 name: .myNotification,
                 object: nil,
                 userInfo: ["name" : "伝える内容"]
          )
        }
    }
    
    func setupObserver() {
        print("observer")
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.handleNotification(_:)),
            name: .myNotification,
            object: nil //複数のオブジェクトからの通知
        )
    }
    
    @objc func handleNotification(_ sender: Notification) {
        print("handleNotification")
        print(modeSet)
        switch modeSet {
        case "concentrate":
            breakModeSet()
            modeSet = "break"
        case "break":
            if (loopCounter <= 3) {
                concentrateModeSet()
                modeSet = "concentrate"
                loopCounter += 1
                pomodoroCounterLabel.text = "\(loopCounter)/4"
                print(loopCounter)
            } else {
                print("終了")
                loopCounter += 1
                pomodoroCounterLabel.text = "\(loopCounter)/4"
            }
        default:
            break
        }
        if(loopCounter <= 3) {
            timerRun()
        } else {
            print("タイマー終了")
            titleLabel.text = "お疲れ様でした"
            timer.invalidate()
        }
    }
}

extension NSNotification.Name {
    static let myNotification = NSNotification.Name("Yoshi")
}
