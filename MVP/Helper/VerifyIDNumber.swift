//
//  VerifyIDNumber.swift
//  GoldenBrotherApp
//
//  Created by 謝佳瑋 on 2016/11/24.
//  Copyright © 2016年 謝佳瑋. All rights reserved.
//

import Foundation

struct VerifyIDNumber {
    let pidCharArray = [ "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z" ]
    // 原身分證英文字應轉換為10~33，這裡直接作個位數*9+10
    let pidIDInt = [ 1, 10, 19, 28, 37, 46, 55, 64, 39, 73, 82, 2, 11, 20, 48, 29, 38, 47, 56, 65, 74, 83, 21, 3, 12, 30 ]
    // 原居留證第一碼英文字應轉換為10~33，十位數*1，個位數*9，這裡直接作[(十位數*1) mod 10] + [(個位數*9) mod 10]
    let pidResidentFirstInt = [ 1, 10, 9, 8, 7, 6, 5, 4, 9, 3, 2, 2, 11, 10, 8, 9, 8, 7, 6, 5, 4, 3, 11, 3, 12, 10 ]
    // 原居留證第二碼英文字應轉換為10~33，並僅取個位數*6，這裡直接取[(個位數*6) mod 10]
    let pidResidentSecondInt = [0, 8, 6, 4, 2, 0, 8, 6, 2, 4, 2, 0, 8, 6, 0, 4, 2, 0, 8, 6, 4, 2, 6, 0, 8, 4]
    
    enum VerifyItem:String{
        case General = "^([A-Z]{1}[1-2]{1}[0-9]{8})$"
        case Foreign = "^([A-Z]{1}[A-D]{1}[0-9]{8})$"
    }
    ///檢查IDnumber格式
    func isValidIDorRCNumber(idNumber:String)->Bool{
        if idNumber == "" {
            return false
        }
        
        var charAry = [Character]()
        for char in idNumber.uppercased().characters{
            charAry.append(char)
        }
        print(charAry)
        var verifyNum = 0
        let rxG = RegexVerification(VerifyItem.General.rawValue)
        if rxG.match(input: idNumber){
            
            verifyNum += pidIDInt[pidCharArray.index(of: charAry[0].description)!]
            var j = 8
            for i in 1...8{
                
                verifyNum += Int(charAry[i].description)! * j
                j-=1
            }
            verifyNum = (10 - (verifyNum % 10)) % 10
            print(verifyNum == Int(charAry[9].description)!)
            return verifyNum == Int(charAry[9].description)!
        }
        verifyNum = 0
        let rxF = RegexVerification(VerifyItem.Foreign.rawValue)
        if rxF.match(input: idNumber){
            verifyNum += pidResidentFirstInt[pidCharArray.index(of: charAry[0].description)!]
            verifyNum += pidResidentSecondInt[pidCharArray.index(of: charAry[1].description)!]
            var j = 7
            for i in 2...8{
                print(charAry[i].description)
                verifyNum += Int(charAry[i].description)! * j
                j-=1
            }
            verifyNum = (10 - (verifyNum % 10)) % 10
            print(verifyNum == Int(charAry[9].description)!)
            return verifyNum == Int(charAry[9].description)!
        }
        return false
    }
}
