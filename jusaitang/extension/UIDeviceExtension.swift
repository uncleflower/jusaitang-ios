//
//  UIDeviceExtension.swift
//  jusaitang
//
//  Created by Jiehao Zhang on 2021/2/15.
//

import UIKit

public extension UIDevice {
    
    /*
     iPhoneX "iPhone10,3" "iPhone10,6"
     iPhoneXs "iPhone11,2"
     iPhoneXs Max "iPhone11,6"
     iPhoneXR "iPhone11,8"iPhone 11 "iPhone12,1"
     iPhone 11 Pro "iPhone12,3"
     iPhone 11 Pro Max "iPhone12,5"
     */
    static var modelName: String {
        
        var systemInfo = utsname()
        
        uname(&systemInfo)
        
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        
        let identifier = machineMirror.children.reduce("") { identifier, element in
            
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            
            return identifier + String(UnicodeScalar(UInt8(value)))
            
        }
        return identifier
    }
}
