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
    @IBOutlet weak var circlarProgressBarView: MBCircularProgressBarView!
    @IBOutlet weak var timerTextLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    var timer = Timer()
    var progressBarMinimumValue: Int = 0// プログレスバー開始値
    var maxTime: Int = 1500// プログレスバー最大値
    static let concentrateTime: Int = 3// 集中する時間設定
    static let breakTime: Int = 3// 休憩する時間設定
    var loopCounter: Int = 0
    var openingTitleLabel: String = "PomodoroTimer"
    var modeSet: String = "concentrate"
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        setupObserver()// 通知受信
        // 初期値セット
        titleLabel.text = openingTitleLabel
        maxTime = ViewController.concentrateTime
        circlarProgressBarView.value = 0
        circlarProgressBarView.maxValue = CGFloat(maxTime)// プログレスバー最大値
        stopButton.isHidden = true
        resetButton.isHidden = true
    }

    @IBAction func startButtonPressed(_ sender: UIButton) {
        startButton.isHidden = true
        stopButton.isHidden = false
        resetButton.isHidden = true
        titleLabel.text = "集中モード"
        timerRun()
    }
    @IBAction func stopButtonPressed(_ sender: UIButton) {
        startButton.isHidden = false
        stopButton.isHidden = true
        resetButton.isHidden = false
        timer.invalidate()
    }
    @IBAction func resetButtonPressed(_ sender: UIButton) {
        // ボタン初期表示
        startButton.isHidden = false
        resetButton.isHidden = true
        timer.invalidate()
        // タイマーリセット
        timerTextLabel.text = "25:00"
        // タイトルリセット
        titleLabel.text = openingTitleLabel
        // プログレスバーリセット
        progressBarMinimumValue = 0
        circlarProgressBarView.value = 0
        maxTime = 3
        // ループカウンターリセット
        loopCounter = 0
        pomodoroCounterLabel.text = "\(loopCounter)/4"
        circlarProgressBarView.maxValue = CGFloat(maxTime)
//        NotificationCenter.default.removeObserver(self)
    }
    private func timerRun() {
        timer = Timer.scheduledTimer(
            timeInterval: 1.0,
            target: self,
            selector: #selector(updateTimer),
            userInfo: nil,
            repeats: true
        )
    }
    func concentrateModeSet() {
        titleLabel.text = "集中モード"
        timerTextLabel.text = "25:00"
        maxTime = ViewController.concentrateTime
        circlarProgressBarView.value = 0
        progressBarMinimumValue = 0
        circlarProgressBarView.maxValue = CGFloat(ViewController.concentrateTime)
    }

    func breakModeSet() {
        titleLabel.text = "休憩中"
        timerTextLabel.text = "5:00"
        maxTime = ViewController.breakTime
        progressBarMinimumValue = 0
        circlarProgressBarView.value = 0
        circlarProgressBarView.maxValue = CGFloat(ViewController.breakTime)
    }
    @objc func updateTimer() {
        if maxTime >= 1 {
            // カウントラベル更新
            let minutesLabel: String
            let secondsLabel: String
            maxTime -= 1 // 25分（1500秒から減算）
            secondsLabel = String(format: "%02d", maxTime % 60)
            minutesLabel = String(format: "%02d", maxTime / 60)
            timerTextLabel.text = "\(minutesLabel):\(secondsLabel)"
            // プログレスバー更新
            progressBarMinimumValue += 1
            circlarProgressBarView.value = CGFloat(progressBarMinimumValue)
        } else {
            timer.invalidate()// タイマー停止
            // 集中モード⇨休憩モード変更
            // 通知送信
//            NotificationCenter.default.post(
//                 name: .myNotification,
//                 object: nil,
//                 userInfo: ["name": "伝える内容"]
//          )
        modeChange()
        }
    }
      // 通知受信処理
//    func setupObserver() {
//        print("observer")
//        NotificationCenter.default.addObserver(
//            self,
//            selector: #selector(self.handleNotification(_:)),
//            name: .myNotification,
//            object: nil // 複数のオブジェクトからの通知
//        )
//    }
    func modeChange() {
        // 集中モードと休憩モード切替`
        switch modeSet {
        case "concentrate":
            breakModeSet()
            modeSet = "break"
        case "break":
            if loopCounter <= 3 {
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
        // セット終了処理
        if loopCounter <= 3 {
            timerRun()
        } else {
            print("タイマー終了")
            titleLabel.text = "お疲れ様でした"
            timer.invalidate()
            stopButton.isHidden = true
            resetButton.isHidden = false
        }
    }
//    @objc func handleNotification(_ sender: Notification) {
//        print("handleNotification")
//        print(modeSet)
//        // 集中モードと休憩モード切替`
//        switch modeSet {
//        case "concentrate":
//            breakModeSet()
//            modeSet = "break"
//        case "break":
//            if loopCounter <= 3 {
//                concentrateModeSet()
//                modeSet = "concentrate"
//                loopCounter += 1
//                pomodoroCounterLabel.text = "\(loopCounter)/4"
//                print(loopCounter)
//            } else {
//                print("終了")
//                loopCounter += 1
//                pomodoroCounterLabel.text = "\(loopCounter)/4"
//            }
//        default:
//            break
//        }
//        // セット終了処理
//        if loopCounter <= 3 {
//            timerRun()
//        } else {
//            print("タイマー終了")
//            titleLabel.text = "お疲れ様でした"
//            timer.invalidate()
//            stopButton.isHidden = true
//            resetButton.isHidden = false
//        }
//    }
}

//extension NSNotification.Name {
//    static let myNotification = NSNotification.Name("Yoshi")
//}
