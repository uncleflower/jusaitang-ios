//
//  DateExtension.swift
//  an-xin-bang
//
//  Created by Jiehao Zhang on 2020/7/22.
//  Copyright © 2020 IdeThink Inc. All rights reserved.
//

import Foundation


extension Date{
    static var now:Date {
        return Date()
    }
    
    static var calendar:Calendar{
        return Calendar.current
    }
    
    var day:Int{
        return Date.calendar.component(.day, from: self)
    }
    
    var hour:Int{
        return Date.calendar.component(.hour, from: self)
    }
    
    var stamp:Int{
        return Int(NSDate().timeIntervalSince1970)
    }
    
    var timestamp:Int{
        return Int(NSDate().timeIntervalSince1970)
    }
    
    static func getDateFromTimeStamp(timeStamp:String) ->Date {
        let interval:TimeInterval = TimeInterval.init(timeStamp)!
        return Date(timeIntervalSince1970: interval)
    }
    
    func currentDifference() -> String {
        let calendar = Calendar.current
        if calendar.isDateInYesterday(self) {
            return "昨天 \(self.toString(dateFormat: "HH:mm"))"
        } else if calendar.isDateInToday(self) {
            return "今天 \(self.toString(dateFormat: "HH:mm"))"
        }
        else if calendar.isDateInTomorrow(self) {
            return "明天 \(self.toString(dateFormat: "HH:mm"))"
        }
        else {
            return self.toString(dateFormat: "yyyy-MM-dd HH:mm")
        }
    }
    
    func toString(dateFormat:String = "yyyy-MM-dd HH:mm:ss") -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale.init(identifier: "zh_CN")
        formatter.dateFormat = dateFormat
        let date = formatter.string(from: self)
        return date
    }
    
    func updateTimeToCurrennTime(timeStamp: Double) -> String {
            //获取当前的时间戳
            let currentTime = Date().timeIntervalSince1970
            //时间戳为毫秒级要 ／ 1000， 秒就不用除1000，参数带没带000
            let timeSta:TimeInterval = TimeInterval(timeStamp)
            //时间差
            let reduceTime : TimeInterval = currentTime - timeSta
            //时间差小于60秒
            if reduceTime < 60 {
                return "刚刚"
            }
            //时间差大于一分钟小于60分钟内
            let mins = Int(reduceTime / 60)
            if mins < 60 {
                return "\(mins)分钟前"
            }
            let hours = Int(reduceTime / 3600)
            if hours < 24 {
                return "\(hours)小时前"
            }
            let days = Int(reduceTime / 3600 / 24)
            if days < 30 {
                return "\(days)天前"
            }
            //不满足上述条件---或者是未来日期-----直接返回日期
            let date = NSDate(timeIntervalSince1970: timeSta)
            let dfmatter = DateFormatter()
            //yyyy-MM-dd HH:mm:ss
            dfmatter.dateFormat="yyyy年MM月dd日 HH:mm:ss"
            return dfmatter.string(from: date as Date)
        }
    
    func checkRemainTime(timeStamp: Double, expiredTitle: String) -> String {
        let currentTime = Date().timeIntervalSince1970
        //时间戳为毫秒级要 ／ 1000， 秒就不用除1000，参数带没带000
        let timeSta:TimeInterval = TimeInterval(timeStamp)
        //时间差
        let reduceTime : TimeInterval = timeSta - currentTime
        //时间差为负数
        if reduceTime <= 0 {
            return expiredTitle
        }
        //时间差小于60秒
        if reduceTime < 60 {
            return "剩余\(reduceTime)秒"
        }
        //时间差大于一分钟小于60分钟内
        let mins = Int(reduceTime / 60)
        if mins < 60 {
            return "剩余\(mins)分钟"
        }
        let hours = Int(reduceTime / 3600)
        if hours < 24 {
            return "剩余\(hours)小时"
        }
        let days = Int(reduceTime / 3600 / 24)
        return "剩余\(days)天"
    }
}
