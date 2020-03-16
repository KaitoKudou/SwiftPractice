//
//  ListViewController.swift
//  MyNewsReader
//
//  Created by 工藤海斗 on 2020/03/16.
//  Copyright © 2020 工藤海斗. All rights reserved.
//

import Foundation
import UIKit

class ListViewController : UITableViewController, XMLParserDelegate {
    
    var parser : XMLParser!
    var items = [Item]() // すべての記事を格納
    var item : Item? // 1つの記事を格納
    var currentString = "" // 抽出した文字列を一時的に保存
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        return cell
    }
}
