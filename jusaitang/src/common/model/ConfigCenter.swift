//
//  ConfigCenter.swift
//  jusaitang
//
//  Created by Jiehao Zhang on 2021/3/12.
//

import UIKit
import HandyJSON

class ConfigCenter: NSObject ,HandyJSON {
    
    static var shared = ConfigCenter()
    
    var share: ShareConfig = ShareConfig()
    
    required override init() {
        super.init()
    }
}

class ShareConfig: HandyJSON {
    
    var image: String = "https://www.tracys.cn/asserts/img/logo.png"
    var title: String = "快捷报名，快点一起卷起来"
    var detail: String = "一键组队，超方便"
    
    required init() {
    }
}
