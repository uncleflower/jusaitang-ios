//
//  ChangeInfoVM.swift
//  jusaitang
//
//  Created by Jiehao Zhang on 2021/3/4.
//

import UIKit
import RxCocoa
import RxSwift

class ChangeInfoVM: NSObject {
    
    private let disposeBag = DisposeBag()
    
    override init() {
        super.init()
    }
    
    func changeInfo(phone: String = "", email: String = "",_ completion: @escaping (IError?) -> Void) -> IError? {
        
        if phone != "" {
            if !phoneValidation(phone: phone) {
                return IError.init(code: .phoneFormatWrong)
            }
        }
        
        let req = AccountAPI.ChangeInfoReq()
        req.email = email
        req.phone = phone
        AccountAPI.changeInfo(request: req) { (_, error) in
            if let error = error {
                completion(error)
                return
            }
            completion(nil)
        }
        
        return nil
    }
    
    func phoneValidation(phone:String)->Bool {
        let phone = phone.removeAllSpace()
        let mobile = "^1(7[0-9]|3[0-9]|5[0-35-9]|8[025-9])\\d{8}$"
        let  CM = "^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$"
        let  CU = "^1(3[0-2]|5[256]|8[56])\\d{8}$"
        let  CT = "^1((33|53|8[09])[0-9]|349)\\d{7}$"
        let regextestmobile = NSPredicate(format: "SELF MATCHES %@",mobile)
        let regextestcm = NSPredicate(format: "SELF MATCHES %@",CM )
        let regextestcu = NSPredicate(format: "SELF MATCHES %@" ,CU)
        let regextestct = NSPredicate(format: "SELF MATCHES %@" ,CT)
        if ((regextestmobile.evaluate(with: phone) == true)
            || (regextestcm.evaluate(with: phone)  == true)
            || (regextestct.evaluate(with: phone) == true)
            || (regextestcu.evaluate(with: phone) == true)){
            return true
        }
        
        return false
    }
    
}
