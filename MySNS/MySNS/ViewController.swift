//
//  ViewController.swift
//  MySNS
//
//  Created by 工藤海斗 on 2020/03/05.
//  Copyright © 2020 工藤海斗. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBAction func showActivityView(_ sender: UIBarButtonItem) {
        
        // UIActivityViewControllerのインスタンスを生成
        let controller = UIActivityViewController(activityItems: [imageView.image!], applicationActivities: nil)
        
        // UIActivityViewControllerを表示
        present(controller, animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

