//
//  LoginAPI.swift
//  jusaitang
//
//  Created by Jiehao Zhang on 2021/2/15.
//

import UIKit
import Alamofire
import HandyJSON

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
            path: "/user/login",
            request: request
        )
        request.post(completion)
    }

    static func logout(request: EmptyReq, completion: @escaping(EmptyRes?,IError?) -> Void){
        let request = APIRequest<EmptyRes>(
            path: "/user/logout",
            request: request
        )
        request.get(auth: .login, completion)
    }
    
    //MARK: 获得用户信息
    class getUserDataRes: HandyJSON {
        var user = User()
        
        required init() {
            
        }
    }
    
    static func getUserData(request: EmptyReq, completion: @escaping(getUserDataRes?,IError?) -> Void){
        let request = APIRequest<getUserDataRes>(
            path: "/user/findUserByUsername",
            request: request
        )
        request.post(auth: .login, completion)
    }
    
}
