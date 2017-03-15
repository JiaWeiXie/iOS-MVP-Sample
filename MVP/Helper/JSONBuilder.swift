//
//  JSONBuilder.swift
//  MVPSample
//
//  Created by 謝佳瑋 on 2017/2/22.
//  Copyright © 2017年 謝佳瑋. All rights reserved.
//

import Foundation
///建立JSON格式字串的類別
class JSONBuilder{
    
    var dictionary = [String:Any]()
    fileprivate var dictionaryJson = [String:String]()
    fileprivate var json:String = ""    ///Dictionary型別轉存JSON Object
    func addObject<T>(key:String,dictionary:Dictionary<String, T>){
        let dictionaryString:String = dictionary.description
        self.dictionaryJson[key] = dictionaryString
        self.dictionary[key] = dictionary
        
    }
    ///新增項目存入JSON
    func addItem<T>(key:String,value:T){
        self.dictionaryJson[key] = value as? String
        self.dictionary[key] = value
    }
    ///Array型別轉存JSON Array
    func addArray<T>(key:String,array:Array<T>){
        let aryStr = array.description.replacingOccurrences(of: "\"", with: "")
        self.dictionaryJson[key] = "\(aryStr)"
        self.dictionary[key] = array
    }
    ///Return String JSON
    func value()->String{
        var json = self.json
        json = self.dictionaryJson.debugDescription
        json = json.replacingOccurrences(of: "[", with: "{", options: .anchored, range: nil)
        let start = json.index(json.endIndex, offsetBy: -1)
        json = json.replacingOccurrences(of: "]", with: "}", options: .anchored, range: start..<json.endIndex)
        return "\(json)"
    }
    ///Return JSON Dictionary
    func value()->Dictionary<String, Any>{
        return self.dictionary
    }
    ///清除JSON Data
    func clear(){
        self.dictionary.removeAll()
        self.dictionaryJson.removeAll()
        self.json = ""
    }
}
