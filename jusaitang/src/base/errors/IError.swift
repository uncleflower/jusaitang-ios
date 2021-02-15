//
//  errors.swift
//  UWatChat
//
//  Created by Duona Zhou on 5/2/20.
//  Copyright © 2020 IdeThink Inc. All rights reserved.
//

import Foundation

typealias NormalResult = (Bool, String)

let defaultError: String = "请求失败"

class IError: Error{
    public let code:IErrorType
    public let codeInt:Int
    public let message:String?
    
    init(code: Int = 0, message:String? = nil){
        self.codeInt = code
        self.message = message
        if let errorType = IErrorType.init(rawValue: codeInt){
            self.code = errorType
        }else{
            self.code = .unknown
        }
    }
    init(code: IErrorType) {
        self.codeInt = code.rawValue
        self.message = ""
        self.code = code
    }

    init?(error: Error?) {
        if error == nil{
            return nil
        }
        
        self.code = .networkError
        self.codeInt = -2
        self.message = ""
    }
    
    
    func error()->Error{
        let error = NSError(domain: "com.uchat", code: self.codeInt, userInfo: [NSLocalizedDescriptionKey: self.code.errorMessage()])
        return error as Error
    }
    

    public func print(_ items: Any..., separator: String = " ", terminator: String = "\n"){
        
    }

    public func debugPrint(_ items: Any..., separator: String = " ", terminator: String = "\n"){
        
    }
    

    public func print<Target>(_ items: Any..., separator: String = " ", terminator: String = "\n", to output: inout Target) where Target : TextOutputStream{
        
    }
    

    public func debugPrint<Target>(_ items: Any..., separator: String = " ", terminator: String = "\n", to output: inout Target) where Target : TextOutputStream{
        
    }
}
