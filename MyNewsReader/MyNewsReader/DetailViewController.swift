//
//  DetailViewController.swift
//  MyNewsReader
//
//  Created by 工藤海斗 on 2020/03/18.
//  Copyright © 2020 工藤海斗. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController : UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    var link : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let url = URL(string: self.link) else {
            return
        }
        let request = URLRequest(url: url)
        self.webView.load(request)
    }
}
