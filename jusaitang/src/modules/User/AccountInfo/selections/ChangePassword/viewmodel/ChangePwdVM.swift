//
//  ChangePwdVM.swift
//  jusaitang
//
//  Created by Jiehao Zhang on 2021/3/4.
//

import UIKit
import RxCocoa
import RxSwift
import SwiftyRSA

class ChangePwdVM: NSObject {
    
    private let disposeBag = DisposeBag()
    
    let oldPwdObservable = BehaviorSubject<String>(value: "")
    let newPwdObservable = BehaviorSubject<String>(value: "")
    let checkPwdObservable = BehaviorSubject<String>(value: "")
    
    override init() {
        super.init()
    }
    
    func changePwd(_ completion: @escaping (IError?) -> Void) -> IError? {
        guard let oldPwd = try? oldPwdObservable.value() else {return nil}
        guard let newPwd = try? newPwdObservable.value() else {return nil}
        guard let checkPwd = try? checkPwdObservable.value() else {return nil}
        
        if oldPwd.isEmpty {
            return IError.init(code: .pwdEnpty)
        }
        if newPwd.isEmpty {
            return IError.init(code: .pwdEnpty)
        }
        if checkPwd.isEmpty {
            return IError.init(code: .pwdEnpty)
        }
        if newPwd != checkPwd {
            return IError.init(code: .userRepeatPWDError)
        }
        if newPwd.count < 6 {
            return IError.init(code: .pwdTooShort)
        }
         
        let req = AccountAPI.ChangePasswordReq()
        req.newPassword = newPwd
        req.oldPassword = oldPwd
        AccountAPI.changePassword(request: req) { (_, error) in
            if let error = error {
                completion(error)
                return
            }
            completion(nil)
        }
        
        return nil
    }
}
