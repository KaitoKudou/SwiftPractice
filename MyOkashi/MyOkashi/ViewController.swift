//
//  ViewController.swift
//  MyOkashi
//
//  Created by 工藤海斗 on 2020/01/10.
//  Copyright © 2020 工藤海斗. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UISearchBarDelegate {

    @IBOutlet weak var searchText: UISearchBar!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Search Barのdelegate通知先を設定
        searchText.delegate = self
        
        // 入力のヒントとなるプレースホルダーを設定
        searchText.placeholder = "お菓子の名前を入力してください"
        
    }
    
    // 検索ボタンをクリック時に実行されるdelegateメソッド
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        // キーボードを閉じる
        view.endEditing(true)
        
        guard let searchWord = searchText.text else {
            return
        }
        // デバッグエリアにsearchBarで入力された文字を出力
        print(searchWord)
        searchOkashi(keyword: searchWord)
    }
    
    // json内のitem内のデータ構造
    struct ItemJson : Codable {
        //  お菓子の名称
        let name : String?
        
        // メーカー
        let maker : String?
        
        // 掲載URL
        let url : String?
        
        // 画像URL
        let image : String?
    }
    
    // jsonのデータ構造
    struct ResultJson : Codable {
        // 複数要素
        let item:[ItemJson]?
    }
    
    // お菓子を検索して一覧を表示するメソッド
    // 第一引数：keyword （検索したいワード）
    func searchOkashi(keyword : String) {
        
        // お菓子の検索キーワードをURLエンコードする
        // 全角や制御文字を半角のもじに変換してエンコード
        guard let keyword_encode = keyword.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            return
        }
        
        // リクエストURLの組み立て
        guard let req_url = URL(string: "https://sysbird.jp/toriko/api/?apikey=guest&format=json&keyword=\(keyword_encode)&max=10&order=r") else {
            return
        }
        print(req_url)
        
        // リクエストに必要な情報を生成
        let req = URLRequest(url: req_url)
        
        // データ転送を管理するためのセッションを生成
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        
        // リクエストをタスクとして登録
        let task = session.dataTask(with: req, completionHandler: {
            (data, response, error) in
            
            // セッション終了
            session.finishTasksAndInvalidate()
            
            // エラーハンドリング
            do
            {
                // JSONDecoderインスタンスの取得
                let decoder = JSONDecoder()
                
                // 受け取ったJSONデータをパース（解析）して格納
                let json = try decoder.decode(ResultJson.self, from: data!)
                
                print(json)
            }
            catch
            {
                // エラー処理
                print("エラーが出ました。")
            }
        })
        
        // ダウンロード開始
        task.resume()
    }
    
}

