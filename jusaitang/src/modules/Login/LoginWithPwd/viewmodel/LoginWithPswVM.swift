//
//  LoginWithPswVM.swift
//  jusaitang
//
//  Created by Jiehao Zhang on 2021/3/2.
//

import UIKit
import RxCocoa
import RxSwift

class LoginWithPswVM: NSObject {
    
    private let disposeBag = DisposeBag()
    
    var sIDObservable: BehaviorSubject<String> = BehaviorSubject(value: "")
    
    var pwdObservable: BehaviorSubject<String> = BehaviorSubject(value: "")
    
    override init() {
        super.init()
    }
    
    func loginWithPwd(complete: @escaping(IError?) -> Void) -> IError? {
        let req = LoginAPI.LoginReq()
        guard let sid = try? sIDObservable.value() else {return nil}
        if sid == "" {
            return IError(code: .sidEmpty)
        }
        guard let password = try? pwdObservable.value() else {return nil}
        if password == "" {
            return IError(code: .pwdEnpty)
        }
        req.password = password
        req.userName = sid
        req.roles.append(LoginAPI.RoleId())
        LoginAPI.login(request: req) { (res, error) in
            if let error = error {
                ErrorAlertView.show(error: error, style: .topError)
                return
            }
            
            guard let res = res else {return}
            
            DataManager.shared.saveToken(accessToken: res.accessToken, refreshToken: "")
        }
        return nil
    }
}
