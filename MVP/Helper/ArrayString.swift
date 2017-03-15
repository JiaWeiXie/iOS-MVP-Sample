//
//  ArrayString.swift
//  GoldenBrotherApp
//
//  Created by 謝佳瑋 on 2017/2/6.
//  Copyright © 2017年 謝佳瑋. All rights reserved.
//

import Foundation

struct ArrayString {
    static func on(_ array:Array<[String:Any]>)->String{
        var aryStr = ""
        for i in 0..<array.count {
            var s = array[i].description
            s = s.replacingOccurrences(of: "[", with: "{", options: .anchored, range: s.startIndex..<s.index(s.startIndex, offsetBy: 1))
            s = s.replacingOccurrences(of: "]", with: "}", options: .anchored, range: s.index(s.endIndex, offsetBy: -1)..<s.endIndex)
            if i == 0 {
                aryStr = s
            }else{
                aryStr += ",\(s)"
            }
        }
        aryStr = "[\(aryStr)]"
        return aryStr
    }
    
    static func on(_ array:Array<Int>)->String{
        var aryStr = ""
        for i in 0..<array.count {
            let s = array[i].description
            if i == 0 {
                aryStr = s
            }else{
                aryStr += ",\(s)"
            }
        }
        aryStr = "[\(aryStr)]"
        return aryStr
    }
    
    static func on(_ array:Array<String>)->String{
        var aryStr = ""
        for i in 0..<array.count {
            let s = array[i]
            if i == 0 {
                aryStr = "\"\(s)\""
            }else{
                aryStr += ",\"\(s)\""
            }
        }
        aryStr = "[\(aryStr)]"
        return aryStr
    }
}
