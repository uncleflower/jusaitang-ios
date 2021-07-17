//
//  User.swift
//  jusaitang
//
//  Created by Jiehao Zhang on 2021/3/2.
//

import UIKit
import HandyJSON

class Captain: HandyJSON {
    var uid: String = ""
    var userName: String = ""
    
    func mapping(mapper: HelpingMapper) {
        mapper <<<
            self.uid <-- "userId"
    }
    
    required init() {}
}

class User: HandyJSON {
    var uid: String = ""
    var avatar: String = ""
    var studentNumber: String = ""
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
            self.studentNumber <-- "userName"
        mapper <<<
            self.avatar <-- "userPic"
    }
    
    required init() {
        
    }
}
