//
//  DateHelper.swift
//  MVPSample
//
//  Created by 謝佳瑋 on 2017/2/22.
//  Copyright © 2017年 謝佳瑋. All rights reserved.
//

import Foundation



struct HandleDate{
    
    enum DateSideType:String {
        case Date = "yyyy-MM-dd"
        case Time = "HH:mm:ss"
        case TimeNoSecond = "HH:mm"
        case DateTime = "yyyy-MM-dd HH:mm:ss"
    }
    
    static func format(_ date:Date,style:DateSideType)->String{
        let currentdate = date
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = style.rawValue
        let customDate = dateformatter.string(from: currentdate)
        return customDate
    }
    
    static func now()->String{
        let currentdate = Date()
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
        let customDate = dateformatter.string(from: currentdate)
        return customDate
    }
    
    static func compareWithNow(_ date:Date)->Int{
        let date1 : Date = Date()
        let date2 : Date = date
        
        if date1.compare(date2) == ComparisonResult.orderedAscending {
            return 1
        }else if date1.compare(date2) == ComparisonResult.orderedDescending {
            return -1
        }else {
            return 0
        }
    }
    
    static func compareDate(_ date1:Date,_ date2:Date)->Int{
        if date1.compare(date2) == ComparisonResult.orderedAscending {
            return 1
        }else if date1.compare(date2) == ComparisonResult.orderedDescending {
            return -1
        }else {
            return 0
        }
    }
    
    
    static func toDate(_ dateData : String)->Date{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        
        
        let date = dateFormatter.date(from: dateData)!
        return date
    }
    
    static func toString(_ date : Date)->String{
        var s : String? = nil
        let now : Date = Date()
        var nowString : String? = nil
        let dateFormatter = DateFormatter()
        let dateFormatterH = DateFormatter()
        
        dateFormatter.dateFormat = "MM/dd"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        nowString = dateFormatter.string(from: now)
        s = dateFormatter.string(from: date)
        
        dateFormatterH.dateFormat = "HH:mm a"
        dateFormatterH.amSymbol = "am"
        dateFormatterH.pmSymbol = "pm"
        dateFormatterH.timeZone = TimeZone(identifier: "UTC")
        if s == nowString {
            return dateFormatterH.string(from: date)
        }else{
            return s!
        }
        
        
        
    }
}
