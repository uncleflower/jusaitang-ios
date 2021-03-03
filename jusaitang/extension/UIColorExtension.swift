//
//  UIColorExtension.swift
//  an-xin-bang
//
//  Created by Jiehao Zhang on 2020/7/3.
//  Copyright © 2020 IdeThink Inc. All rights reserved.
//

import UIKit

extension UIColor{
    static var `default`:UIColor{
        get{
            return UIColor(hexString: "#ff7200")!
        }
    }
    
    //  Get color from hex string with alpha value
    public convenience init?(hexString: String, alpha: CGFloat = 1.0) {
        var cString:String = hexString.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            self.init()
            return
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        self.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }

    //  Get color from hex
    public convenience init?(hex: Int, alpha: CGFloat) {
        let hexString = NSString(format: "%2X", hex)
        self.init(hexString: hexString as String , alpha: alpha)
    }
    static func random(hue: CGFloat = CGFloat.random(in: 0...1),
                         saturation: CGFloat = CGFloat.random(in: 0.5...1), // from 0.5 to 1.0 to stay away from white
                         brightness: CGFloat = CGFloat.random(in: 0.5...1), // from 0.5 to 1.0 to stay away from black
                         alpha: CGFloat = 1) -> UIColor {
        return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: alpha)
    }
    
    
    
    func image(size:CGSize = .init(width: 1, height: 1)) -> UIImage {
        let rect = CGRect.init(origin: .zero, size: size)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(self.cgColor)
        context!.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}

