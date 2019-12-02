//
//  ViewController.swift
//  MyMap
//
//  Created by KaitoKudou on 2019/12/02.
//  Copyright © 2019 KaitoKudou. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var inputText: UITextField!
    @IBOutlet weak var dispMap: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 画面表示前にTextFieldのdelegate通知先を設定
        inputText.delegate = self
    }
    
    // delegateによってこのメソッドが実行される
    // 「検索」ボタンが押されると呼ばれる
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        // このメソッドがないと、入力終了後もキーボードが閉じない
        textField.resignFirstResponder()
        
        // 入力された文字列を取り出す
        if let searchKey = textField.text{
            print(searchKey)
        }
        
        return true
    }
    
}

