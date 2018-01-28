//
//  NSObjectExtension.swift
//  UITabSample
//
//  Created by 水野祥子 on 2018/01/28.
//  Copyright © 2018年 sachiko. All rights reserved.
//

import UIKit

extension NSObject {
    class var className: String {
        return String(describing: self)
    }
    
    var className: String {
        return type(of: self).className
    }
}
