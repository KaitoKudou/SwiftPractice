//
//  ListViewController.swift
//  MyNewsReader
//
//  Created by 工藤海斗 on 2020/03/16.
//  Copyright © 2020 工藤海斗. All rights reserved.
//

import UIKit

class ListViewController : UITableViewController, XMLParserDelegate {
    
    var parser : XMLParser!
    var items = [Item]() // すべての記事を格納
    var item : Item? // 1つの記事を格納
    var currentString = "" // 抽出した文字列を一時的に保存
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row].title
        return cell
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startDownload()
    }
    
    // インターネットからダウンロードを開始
    func startDownload(){
        self.items = [] // 古いデータがitemsに入った状態だと重複する記事が生成されるため、初期化
        guard let url = URL(string: "https://wired.jp/rssfeeder/") else {
            return
        }
        guard let parser = XMLParser(contentsOf: url) else {
            return
        }
        self.parser = parser
        self.parser.delegate = self
        self.parser.parse()
    }
    
    // 要素名の開始タグが見つかると毎回呼び出されるデリゲートメソッド
    // 今回だと、<item>を見つけると以下を実行
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
        self.currentString = ""
        
        if elementName == "item"{
            self.item = Item() // １件分のニュース記事を格納する領域を確保
        }
    }
    
    // タグで囲まれた部分の内容を取り出すデリゲートメソッド
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        self.currentString += string
    }
    
    // 要素名の終了タグが見つかると呼ばれるデリゲートメソッド
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        switch elementName {
        case "title":
            self.item?.title = self.currentString
        case "link":
            self.item?.link = self.currentString
        case "item":
            self.items.append(self.item!) // ニュース記事を終わりであるから配列items[]に格納
        default:
            break
        }
    }
    
    // すべてのRSS形式のデータの解析が終わると、呼び出されるデリゲートメソッド
    func parserDidEndDocument(_ parser: XMLParser) {
        self.tableView.reloadData()
    }
    
    /*override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        <#code#>
    }*/
}
