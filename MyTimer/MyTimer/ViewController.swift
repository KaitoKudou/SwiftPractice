//
//  ViewController.swift
//  MyTimer
//
//  Created by KaitoKudou on 2019/12/19.
//  Copyright © 2019 KaitoKudou. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // タイマーの変数を作成
    // Timerクラスのインスタンス
    var timer : Timer?
    
    // 経過時間の変数を作成
    var count = 0
    
    // 設定値を扱うキーを設定
    // 秒数を保持する
    let settingKey = "timer_value"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // UserDefaultsインスタンスを生成
        let settings = UserDefaults.standard
        
        // UserDefaultsに初期値を設定
        settings.register(defaults: [settingKey:10])
    }
    
    // 画面切り替えのタイミングで処理を行う
    // タイマー画面が表示される度に実行される
    override func viewDidAppear(_ animated: Bool) {
        
         // カウント(経過時間)を0にする
        count = 0
        
        // タイマー表示を更新する
        _ = displayUpdate()
    }

    @IBOutlet weak var countDownLabel: UILabel!
    
    @IBAction func settingButtonAction(_ sender: Any) {
        // timerをアンラップしてnowTimerに格納
        if let nowTimer = timer {
            
            // もしタイマーが実行中だったら停止
            if nowTimer.isValid == true {
                
                // タイマー停止
                nowTimer.invalidate()
            }
        }
        
        // 画面遷移を行う
        performSegue(withIdentifier: "goSetting", sender: nil)
    }
    
    @IBAction func startButtonAction(_ sender: Any) {
        // timerをアンラップしてnowTimerに格納
        if let nowTimer = timer {
            
            // もしタイマーが実行中だったらスタートしない
            if nowTimer.isValid == true {
                return // 何もしない
            }
        }
        
        // タイマーをスタート
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerInterrupt(_:)), userInfo: nil, repeats: true)
    }
    
    @IBAction func stopButtonAction(_ sender: Any) {
         // timerをアンラップしてnowTimerに格納
        // アンラップしてtimerに値が存在する時、タイマーを停止
        if let nowTimer = timer {
            
            // もしタイマーが、実行中だったら停止
            if nowTimer.isValid == true {
                 // タイマーを停止
                nowTimer.invalidate()
            }
        }
    }
    
    // 画面の更新をする（戻り値：remainCount：残り時間）
    func displayUpdate() -> Int{
        // UserDefaultsインスタンスを生成
        let settings = UserDefaults.standard
        
        // 取得した秒数をtimerValueに格納
        let timerValue = settings.integer(forKey: settingKey)
        
        // 残り時間(remainCount)を生成
        let remainCount = timerValue - count
        
        // remainCountをcountDownLabelに反映
        countDownLabel.text = "残り\(remainCount)秒"
        
        return remainCount
    }
    
    // 経過時間の処理
    @objc func timerInterrupt(_ timer:Timer){
        // 経過時間を足す
        count += 1
        
        // displayUpdate()が0以下の時、タイマーを止める
        if displayUpdate() <= 0 {
            // 初期化し処理
            count = 0
            
            // タイマー停止
            timer.invalidate()
            
            /*----------------秒数が0になったらダイアログポップアップを表示---------------*/
            // ダイアログを作成
            let alertController = UIAlertController(title: "終了", message: "タイマー終了時間です", preferredStyle: .alert)
            
            // ダイアログに表示するOKボタンを作成
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            
            // OKボタンをダイアログに追加
            alertController.addAction(defaultAction)
            
            // ダイアログを表示
            present(alertController, animated: true, completion: nil)
        }
    }
    
}

