//
//  SecurityMD5.swift
//  GoldenBrotherApp
//
//  Created by 謝佳瑋 on 2016/11/25.
//  Copyright © 2016年 謝佳瑋. All rights reserved.
//

import Foundation

struct SecurityMD5 {
    var target:String
    func value() -> String {
        let string = target
        var digest = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
        if let data = string.data(using: String.Encoding.utf8) {
            CC_MD5((data as NSData).bytes, CC_LONG(data.count), &digest)
        }
        
        var digestHex = ""
        for index in 0..<Int(CC_MD5_DIGEST_LENGTH) {
            digestHex += String(format: "%02x", digest[index])
        }
        
        return digestHex
    }
}
