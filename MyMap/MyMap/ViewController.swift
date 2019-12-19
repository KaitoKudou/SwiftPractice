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
        // デリゲートの通知先を自分自身に設定
        inputText.delegate = self
    }
    
    // delegateによってこのメソッドが実行される
    // delegateメソッド
    // 「検索」ボタンが押されると呼ばれる
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        // このメソッドがないと、入力終了後もキーボードが閉じない
        textField.resignFirstResponder()
        
        // 入力された文字列を取り出す
        if let searchKey = textField.text{
            print(searchKey)
            
            let geocoder = CLGeocoder(); // CLGeocoderインスタンスを生成
            
            // 入力された文字から位置情報を取得
            geocoder.geocodeAddressString(searchKey, completionHandler: { (placemarks, error) in
                
                // 位置情報が尊意するときは、unwrapPlacemarksに取り出す
                if let unwrapPlacemarks = placemarks{
                    
                    // 1件目を取り出す
                    if let firstPlacemark = unwrapPlacemarks.first{
                        
                        // 位置情報を取り出す
                        // locationには、経度・緯度、高度などの情報が入っている
                        if let location = firstPlacemark.location{
                            
                            // 位置情報から経度・緯度をtargetCoordinateに取り出す
                            // coordinateには、経度・緯度が格納されている
                            let targetCoodinate = location.coordinate
                            
                            //　経度・緯度をでバックエリアに表示
                            print(targetCoodinate)
                            
                            // MKPointAnnotationインスタンスを生成し、ピンを作成
                            let pin = MKPointAnnotation();
                            
                            // ピンの置く場所に経度・緯度を設定
                            pin.coordinate = targetCoodinate
                            
                            // ピンにつけるタイトルを設定
                            pin.title = searchKey
                            
                            // ピンを地図に置く
                            self.dispMap.addAnnotation(pin)
                            
                            // 経度・緯度を中心として、半径500mの範囲を表示
                            self.dispMap.region = MKCoordinateRegion(center: targetCoodinate, latitudinalMeters: 500.0, longitudinalMeters: 500.0)
                        }
                    }
                }
            })
        }
        return true
    }
    
    @IBAction func changeMapButton(_ sender: Any) {
        
        // mapTypeプロパティの値で場合わけ
        // 標準⇨航空写真⇨航空写真＋標準
        // ⇨3D Flyover ⇨ 3D Flyover＋標準
        // ⇨交通機関
        
        /*if dispMap.mapType == .standard{
            dispMap.mapType = .satellite
        }
        else if dispMap.mapType == .satellite{
            dispMap.mapType = .hybrid
        }
        else if dispMap.mapType == .hybrid{
            dispMap.mapType = .satelliteFlyover
        }
        else if dispMap.mapType == .satelliteFlyover{
            dispMap.mapType = .hybridFlyover
        }
        else if dispMap.mapType == .hybridFlyover{
            dispMap.mapType = .mutedStandard
        }
        else{
            dispMap.mapType = .standard
        }*/
        
        switch dispMap.mapType {
            
        case .standard:
                dispMap.mapType = .satellite
        case .satellite:
            dispMap.mapType = .hybrid
        case .hybrid:
            dispMap.mapType = .satelliteFlyover
        case .satelliteFlyover:
            dispMap.mapType = .hybridFlyover
        case .hybridFlyover:
            dispMap.mapType = .mutedStandard
        default:
            dispMap.mapType = .standard
        }
        
        
    }
    
}
        

