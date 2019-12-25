//
//  SettingViewController.swift
//  MyTimer
//
//  Created by KaitoKudou on 2019/12/19.
//  Copyright © 2019 KaitoKudou. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    // UIPickerViewに表示するデータをArrayで作成
    let settingArray : [Int] = [10, 20, 30, 40, 50, 60]
    
    //  設定値を覚えるキーを設定
    let settingKey = "timer_value"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // timerSettingPickerのデリゲートとデータソースの通知先を指定
        timerSettingPicker.delegate = self
        timerSettingPicker.dataSource = self
        
        // UserDefaultsの取得
        let settings = UserDefaults.standard
        let timerValue = settings.integer(forKey: settingKey)
        
        // Pickerの選択を合わせる
        for row in 0 ..< settingArray.count {
            if settingArray[row] == timerValue {
                timerSettingPicker.selectRow(row, inComponent: 0, animated: true)
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBOutlet weak var timerSettingPicker: UIPickerView!
    
    
    @IBAction func decisionButtonAction(_ sender: Any) {
        
        // 前の画面に戻る
        self.navigationController?.popViewController(animated: true)
    }
    
    // UIPickerViewの列数を設定
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1 // 今回は1列
    }
    
    // UIPickerViewの行数を取得
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return settingArray.count
    }
    
    // UIPickerViewに表示する内容を設定
    // delegateメソッド
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(settingArray[row])
    }
    
    // picker選択時に実行
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        // UserDefaultsを設定
        let settings = UserDefaults.standard
        settings.setValue(settingArray[row], forKey: settingKey) // 選択された秒数を保存
        settings.synchronize() // データを即時に永続化
        print(settingArray[row])
    }
}