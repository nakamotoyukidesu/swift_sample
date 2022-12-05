//
//  NSObjectExtension.swift
//  RamenInfo
//
//  Created by 藤田優作 on 2021/01/21.
//

import Foundation

extension NSObject {
    class var className: String {
        return String(describing: self)
    }
    
    var className: String {
        return type(of: self).className
    }
}

