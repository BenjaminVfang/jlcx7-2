//
//  extension.swift
//  计量查询
//
//  Created by 方振宇 on 16/7/28.
//  Copyright © 2016年 fzy. All rights reserved.
//

import UIKit
extension UIScrollView {
    override open func  touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.next?.touchesBegan(touches, with: event)
    }
}
