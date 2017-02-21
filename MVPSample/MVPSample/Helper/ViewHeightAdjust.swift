//
//  ViewHeightAdjust.swift
//  GoldenBrotherApp
//
//  Created by 謝佳瑋 on 2017/2/14.
//  Copyright © 2017年 謝佳瑋. All rights reserved.
//

import Foundation
import UIKit

class ViewHeightAdjust{
    
    var text:NSString = ""
    var frame:CGRect = CGRect.zero
    var textFrame:CGSize = CGSize.zero
    var lines = 0
    var lineAry = [String.CharacterView()]
    
    init(text:String, fontSize:CGFloat,viewFrame:CGRect){
        var fontSize = fontSize
        self.frame = viewFrame
        self.text = text as NSString
        self.lineAry = text.characters.split(separator: "\n")
        self.lines = self.lineAry.count
        if fontSize<=0 {
            fontSize = 14.0
        }
        self.textFrame = self.text.size(attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: fontSize)])
    }
    
    
    func textHeight(doing:(_ ary:[String.CharacterView])->CGFloat)->CGFloat{
        var value = CGFloat(0.0)
        value += doing(self.lineAry)
        
        return value
    }
}
