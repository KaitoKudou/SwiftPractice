//
//  ViewController.swift
//  MyCamera
//
//  Created by KaitoKudou on 2019/12/28.
//  Copyright © 2019 KaitoKudou. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBOutlet weak var pictureImage: UIImageView!
    
    // 「カメラを起動する」をタップすると実行される
    @IBAction func cameraButtonAction(_ sender: Any) {
        
        // カメラが利用可能かどうかをチェック
       /* if UIImagePickerController.isSourceTypeAvailable(.camera) {
            print("カメラは利用できます")
            
            // (1) UIImagePickerControllerのインスタンスを生成
            let imagePickerController = UIImagePickerController()
            
            // (2) sourceTypeにcameraを設定
            // sorceTypeで写真の取得先を設定できる
            // この場合は、cameraから写真を取得する
            imagePickerController.sourceType = .camera
            
            // (3)delegateの通知先を設定
            imagePickerController.delegate = self
            
            // (4) モーダルビューでカメラを表示
            present(imagePickerController, animated: true, completion: nil)
        }
        else {
            print("カメラは利用できません")
        }*/
        
        // カメラかフォトライブラリどちらから画像を取得するか選択
        let alertController = UIAlertController(title: "確認", message: "選択してください", preferredStyle: .actionSheet)
        
        // カメラが利用可能かどうかチェック
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            // カメラを起動するための選択肢を定義
            // UIAlertActionは選択肢を表示させるクラス
            let cameraAction = UIAlertAction(title: "カメラ", style: .default, handler: { (action:UIAlertAction) in
                
                // カメラを起動
                let imagePickerController = UIImagePickerController()
                imagePickerController.sourceType = .camera
                imagePickerController.delegate = self
                self.present(imagePickerController, animated: true, completion: nil)
            })
            alertController.addAction(cameraAction)
        }
        
        
        // フォトライブラリが利用可能かどうかチェック
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            // フォトライブラリを起動するための選択肢を定義
            let photoLibraryAction = UIAlertAction(title: "フォトライブラリ", style: .default, handler: { (action:UIAlertAction) in
                
                // フォトライブラリを起動
                let imagePickerController = UIImagePickerController()
                imagePickerController.sourceType = .photoLibrary
                imagePickerController.delegate = self
                self.present(imagePickerController, animated: true, completion: nil)
            })
            alertController.addAction(photoLibraryAction)
        }
        
        // キャンセルの選択肢を定義
        let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        // ipadで落ちてしまう対策
        alertController.popoverPresentationController?.sourceView = view
        
        // 選択肢を画面に表示
        present(alertController, animated: true, completion: nil)
    }
    
    
    // 「SNSに投稿する」をタップすると実行される
    @IBAction func shareButtonAction(_ sender: Any) {
        
        // 表示画像をアンラップして、シェアする画像を取り出す
        if let shareImage = pictureImage.image {
            
            // UIActivityViewControllerに渡す配列を作成
            let shareItem = [shareImage]
            
            // UIActivityViewControllerにシェア画像を渡す
            // UIActivityViewControllerのインスタンスを生成
            let controller = UIActivityViewController(activityItems: shareItem, applicationActivities: nil)
            
            // ipadで落ちてしまう対策
            controller.popoverPresentationController?.sourceView = view
            
            // UIActivityViewControllerを表示
            present(controller, animated: true, completion: nil)
        }
    }
    
    // cameraでの撮影が終わった後に呼ばれるdelegateメソッド
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        // 撮影した画像をpictureImageに渡す。
        // info[]はAny型なので、UIImage型にキャストする必要がある。
        pictureImage.image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        
        // モーダルビューを閉じる (cameraを閉じる)
        dismiss(animated: true, completion: nil)
    }
}

