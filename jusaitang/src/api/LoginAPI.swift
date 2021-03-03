//
//  LoginAPI.swift
//  jusaitang
//
//  Created by Jiehao Zhang on 2021/2/15.
//

import UIKit
import Alamofire
import HandyJSON

class BaseResponse<T>:HandyJSON{
    var message: String = ""
    var code: Int = 0
    var data: T?
    
    required init() {
    }
}

let apiHost = "http://39.97.102.209:8999"

class LoginAPI: NSObject {
    
    
    //MARK: 登录/退出登录
    class RoleId: HandyJSON {
        var roleId = "2"
        
        required init() {

        }
    }
    
    class LoginReq: HandyJSON {
        var password: String = ""
        var userName: String = ""
        var roles: [RoleId] = [RoleId()]

        required init() {

        }
    }

    class LoginRes:HandyJSON {
        var accessToken: String = ""

        required init() {

        }

        func mapping(mapper: HelpingMapper) {
            mapper <<<
                self.accessToken <-- "token"
        }
    }

    static func login(request: LoginReq, completion: @escaping(LoginRes?,IError?) -> Void){
        let request = APIRequest<LoginRes>(
            path: "/competition/user/login",
            request: request
        )
        request.post(completion)
    }

    static func logout(request: EmptyReq, completion: @escaping(EmptyRes?,IError?) -> Void){
        let request = APIRequest<EmptyRes>(
            path: "/competition/user/logout",
            request: request
        )
        request.get(auth: .login, completion)
    }
    
    //MARK: 获得用户信息
    
    static func getUserData(request: EmptyReq, completion: @escaping(User?,IError?) -> Void){
        let request = APIRequest<User>(
            path: "/competition/user/findUserByUsername",
            request: request
        )
        request.post(auth: .login, completion)
    }
    
}
