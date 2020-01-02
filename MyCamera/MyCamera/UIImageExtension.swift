//
//  UIImageExtension.swift
//  MyCamera
//
//  Created by KaitoKudou on 2020/01/02.
//  Copyright © 2020 KaitoKudou. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    
    // 写真のサイズを横幅1024pxに縮小する
    func resize() -> UIImage? {
        let rate = 1024.0 / self.size.width
        let rect = CGRect(x: 0, y: 0, width: self.size.width * rate, height: self.size.height * rate)
        
        UIGraphicsBeginImageContext(rect.size)
        self.draw(in: rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
}
