//
//  ViewController.swift
//  MyMusic
//
//  Created by KaitoKudou on 2019/11/17.
//  Copyright © 2019 KaitoKudou. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    // シンバルの音源ファイルを指定
    let cymbalPath = Bundle.main.bundleURL.appendingPathComponent("cymbal.mp3")
    
    // シンバル用のプレイヤーインスタンスを作成
    // cymbalPlayerがシンバルを鳴らす
    var cymbalPlayer: AVAudioPlayer!
    
    @IBAction func cymbal(_ sender: Any) {
        
        do{
            //　シンバル用のプレイヤーに、音楽ファイル名を指定
            cymbalPlayer = try AVAudioPlayer(contentsOf: cymbalPath, fileTypeHint: nil)
            
            // シンバルの音声を再生
            cymbalPlayer.play()
        }
        catch{
            print("シンバルを鳴らそうとしたけど、エラーが発生")
        }
    }
    
    // ギター用の音源ファイルを指定
    let guitarPath = Bundle.main.bundleURL.appendingPathComponent("guitar.mp3")
    
    // ギター用のプレイヤーインスタンスを作成
    var guitarPlayer : AVAudioPlayer!
    
    @IBAction func guitar(_ sender: Any) {
        
        do {
            guitarPlayer = try AVAudioPlayer(contentsOf: guitarPath, fileTypeHint: nil)
            guitarPlayer.play()
        }
        catch {
            print("ギターを鳴らそうとしたけど、エラーが発生")
        }
    }
    
    // バックミュージック用の音源ファイルを指定
    let backmusicPath = Bundle.main.bundleURL.appendingPathComponent("backmusic.mp3")
    
    // バックミュージック用のプレイヤーインスタンスを作成
    var backmusicPlayer: AVAudioPlayer!
    
    @IBAction func play(_ sender: Any) {
        
        do {
            backmusicPlayer =  try AVAudioPlayer(contentsOf: backmusicPath, fileTypeHint: nil)
            backmusicPlayer.numberOfLoops = -1
            backmusicPlayer.play()
        }
        catch {
            print("エラーが発生")
        }
    }
    
    // stopボタンが押された時
    @IBAction func stop(_ sender: Any) {
        
        // バックミュージックを停止
        backmusicPlayer.stop()
    }
    
    
}

