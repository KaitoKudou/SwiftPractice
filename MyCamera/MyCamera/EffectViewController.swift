//
//  EffectViewController.swift
//  MyCamera
//
//  Created by KaitoKudou on 2020/01/01.
//  Copyright © 2020 KaitoKudou. All rights reserved.
//

import UIKit

class EffectViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //画面遷移時に元の画像を表示
        effectImage.image = originalImage
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    // エフェクト前画像
    // 前の画面より画像を設定
    var originalImage : UIImage?
    
    // フィルタ名を列挙した配列(Array)
    // 0: モノクロ  1: Chrome  2: Fade  3: Instant
    // 4: Noir    5: Process  6: Tonal  7: Transfer  8: Sepia Tone
    let filterArray = ["CIPhotoEffectMono", "CIPhotoEffectChrome", "CIPhotoEffectFade", "CIPhotoEffectInstant",
                        "CIPhotoEffectNoir", "CIPhotoEffectProcess", "CIPhotoEffectTonal",
                        "CIPhotoEffectTransfer", "CISepiaTone"]
    
    // 選択中のエフェクトの添字
    var filterSelectNumber = 0
    
    @IBOutlet weak var effectImage: UIImageView!
    
    @IBAction func effectButtonAction(_ sender: Any) {
        
        // エフェクト前の画像をアンラップして、エフェクト用画像として取り出す
        if let image = originalImage {
        
            // フィルター名を指定
            let filterName = filterArray[filterSelectNumber]
            
            // 次に更新するエフェクトの添字に更新
            filterSelectNumber += 1
            
            // 添字が配列の個数と同じかチェック
            if filterSelectNumber == filterArray.count {
                // 同じ場合は、最後まで選択されたので先頭に戻す
                filterSelectNumber = 0
            }
        
            // 元々のだ画像の回転角度を取得
            let rorate = image.imageOrientation
        
            // UIImageの画像をCIImageの画像に変換
            // CIImage形式の画像でエフェクトをかける
            let inputImage = CIImage(image: image)
        
            // フィルターの種類を引数で指定された種類を指定して、CIFilterインスタンスを生成
            guard let effectFilter = CIFilter(name: filterName) else {
                return
            }
        
            // エフェクトのパラメータを初期化
            effectFilter.setDefaults()
        
            // フィルターインスタンスにエフェクトする画像を設定
            //  kCIInputImageKe は入力画像の指定
            effectFilter.setValue(inputImage, forKey: kCIInputImageKey)
        
            // エフェクト後のCIImage形式の画像を取り出す
            guard let outputImage = effectFilter.outputImage else{
                return
            }
        
            // CIContextのインスタンスを取得
            // CIContextは画像を加工するための作業領域
            let ciContext = CIContext(options: nil)
        
            // エフェクト後の画像をCIContext上に描画し、結果をcgImageとしてCGImage形式の画像を取得
            guard let cgImage = ciContext.createCGImage(outputImage, from: outputImage.extent) else {
                return
            }
        
            // エフェクト後の画像をCGImage形式からUIImage形式に変換
            // その後、回転角度(rorate)を指定
            // これらをImageViewに表示
            effectImage.image = UIImage(cgImage: cgImage, scale: 1.0, orientation: rorate)
            }
    }
    
    @IBAction func shareButtonAction(_ sender: Any) {
        
        // 表示画像をアンラップして、シェアする画像を取り出す
        guard let shareImage = effectImage.image?.resize() else {
            return
        }
        
        // UIActivityViewControllerに渡す配列を作成
        let shareItem = [shareImage]
        
        // UIActivityViewControllerにシェア画像を渡す
        // UIActivityViewControllerのインスタンスを生成
        let controller = UIActivityViewController(activityItems: shareItem, applicationActivities: nil)
        
        // シェアボタンの位置を取得
        let button_locate = sender as? UIButton
         // ipadで落ちてしまう対策
        controller.popoverPresentationController?.sourceView = button_locate
        
        // UIActivityViewControllerを表示
        present(controller, animated: true, completion: nil)
        
    }
    
    @IBAction func closeButtonAction(_ sender: Any) {
        //現在の画面を閉じて前の画面に戻る
        dismiss(animated: true, completion: nil)
    }
    
}
