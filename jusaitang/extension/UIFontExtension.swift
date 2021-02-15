//
//  UIFontExtension.swift
//  an-xin-bang
//
//  Created by Jiehao Zhang on 2020/7/3.
//  Copyright © 2020 IdeThink Inc. All rights reserved.
//

import UIKit

extension UIFont {
    
    public convenience init(size: CGFloat){
        self.init(name: "PingFangSC-Regular", size: size)!
    }
    class func pf_light(_ fontSize: CGFloat) -> UIFont{
        if let font = UIFont.init(name: "PingFangSC-Light", size: fontSize) {
            return font
        }
        return UIFont.systemFont(ofSize: fontSize)
    }
//    class func pf_medium(_ fontSize: CGFloat) -> UIFont{
//        if let font = UIFont.init(name: "PingFangSC-Medium", size: fontSize) {
//            return font
//        }
//        return UIFont.systemFont(ofSize: fontSize)
//    }
    class func pf_medium(_ fontSize: CGFloat) -> UIFont{
        if let font = UIFont.init(name: "PingFangSC-Regular", size: fontSize) {
            return font
        }
        return UIFont.systemFont(ofSize: fontSize)
    }
    
    class func pf_regular(_ fontSize: CGFloat) -> UIFont{
        if let font = UIFont.init(name: "PingFangSC-Regular", size: fontSize) {
            return font
        }
        return UIFont.systemFont(ofSize: fontSize)
    }
    class func pf_semibold(_ fontSize: CGFloat) -> UIFont{
        if let font = UIFont.init(name: "PingFangSC-Semibold", size: fontSize) {
            return font
        }
        return UIFont.systemFont(ofSize: fontSize)
    }
}

