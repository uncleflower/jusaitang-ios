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
//        let today = Date()
//        let calendar:Calendar = Calendar.current
//        let day = calendar.component(.day, from: today)
//        let hour = calendar.component(.hour, from: today)
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
}
