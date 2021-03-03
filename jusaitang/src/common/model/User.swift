//
//  User.swift
//  jusaitang
//
//  Created by Jiehao Zhang on 2021/3/2.
//

import UIKit
import HandyJSON

class User: HandyJSON {
    var uid: String = ""
    var username: String = ""
    var password: String = ""
    var name: String = ""
    var phone: String = ""
    var email: String = ""
    var sex: String = ""
    var period: Int = 0
    var college: College = College()
    var userClassName: String = ""
    
    func mapping(mapper: HelpingMapper) {
        mapper <<<
            self.uid <-- "userId"
        mapper <<<
            self.username <-- "userName"
    }
    
    required init() {
        
    }
}
