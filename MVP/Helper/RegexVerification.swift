//
//  RegexVerification.swift
//  GoldenBrotherApp
//
//  Created by 謝佳瑋 on 2016/11/24.
//  Copyright © 2016年 謝佳瑋. All rights reserved.
//

import Foundation
/**
 # 驗證格式
 >格式範例:
 
 ```
 ^(開頭符號）[](限制字元）{}(限制字數）$(結束符號）
 範例格式："^([0-9]{1}[a-z]{2})$"
    （第一個字元0~9第二第三字元a~z）
 範例正確結果：0az
 ```
 */
struct RegexVerification {
    let regex:NSRegularExpression?
    var verifyPattern:String?
    ///建構式，設定驗證格式，ex:^([A-Z]{1}[A-D]{1}[0-9]{8})$
    init(_ verifyPattern:String) {
        self.verifyPattern = verifyPattern
        regex = try? NSRegularExpression(pattern: self.verifyPattern!,
                                         options: .caseInsensitive)
    }
    
    func match(input: String) -> Bool {
        let regexMatches = regex?.matches(in: input,
                                          options: [],
                                          range: NSMakeRange(0, (input as NSString).length))
        if let matches = regexMatches{
            return matches.count > 0
        } else {
            return false
        }
    }
}
