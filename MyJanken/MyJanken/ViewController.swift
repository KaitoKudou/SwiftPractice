//
//  ViewController.swift
//  MyJanken
//
//  Created by KaitoKudou on 2019/11/11.
//  Copyright © 2019 KaitoKudou. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBOutlet weak var answerImageView: UIImageView!
    
    @IBOutlet weak var answerLabel: UILabel!
    
    // じゃんけんの手を数字で表現
    // ０→グー、１→チョキ、２→パー
    var answerNumber = Int.random(in: 0..<3)
    
    //新しいじゃんけんの結果を格納する一時的な変数
    var newAnswerNumber = Int.random(in: 0..<3)

    @IBAction func shuffleAction(_ sender: Any) {
        
        // 前回と同じ結果の場合は、再度乱数を生成
        // 前回と異なる時は、whileを抜ける
        while answerNumber == newAnswerNumber {
            
            // 0〜2の間で整数の乱数を生成
            newAnswerNumber = Int.random(in: 0..<3)
            
        }
        
        // 新しいじゃんけんの結果を格納
        answerNumber = newAnswerNumber
        
        if answerNumber == 0 {
            
            answerLabel.text = "グー"
            answerImageView.image = UIImage(named: "gu")
            
        }
            
        else if answerNumber == 1{
            answerLabel.text = "チョキ"
            answerImageView.image = UIImage(named: "choki")
            
        }
        
        else if answerNumber == 2{
            answerLabel.text = "パー"
            answerImageView.image = UIImage(named: "pa")
            
        }
        
    }
    
}

