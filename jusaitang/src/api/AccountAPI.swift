//
//  AccountAPI.swift
//  jusaitang
//
//  Created by Jiehao Zhang on 2021/3/4.
//

import UIKit
import HandyJSON

class AccountAPI: NSObject {
    //MARK: 修改用户密码
    
    class ChangePasswordReq: HandyJSON {
        var oldPassword: String = ""
        var newPassword: String = ""
        
        func mapping(mapper: HelpingMapper) {
            mapper <<<
                self.oldPassword <-- "rawPassword"
        }
        
        required init() {
        }
    }
    
    static func changePassword(request: ChangePasswordReq, completion: @escaping(EmptyRes?,IError?) -> Void){
        let request = APIRequest<EmptyRes>(
            path: "/user/updatePassword",
            request: request
        )
        request.post(completion)
    }
    
    //MARK: 修改用户信息
    
    class ChangeInfoReq: HandyJSON {
        var email: String = ""
        var phone: String = ""
        
        required init() {
        }
    }
    
    static func changeInfo(request: ChangeInfoReq, completion: @escaping(EmptyRes?,IError?) -> Void){
        let request = APIRequest<EmptyRes>(
            path: "/user/updateUserInfo",
            request: request
        )
        request.post(completion)
    }
}
