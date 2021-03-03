//
//  ErrorType.swift
//  UWatChat
//
//  Created by Duona Zhou on 5/2/20.
//  Copyright © 2020 IdeThink Inc. All rights reserved.
//

import Foundation

enum IErrorType:Int {
    case none = 0 // 参数错误
    case unknown = -1 // 参数错误
    
    case networkError = -20 // 网络错误
    case paramsError = -22 // 参数错误
    
    case sidEmpty           = 1016 //学号为空

    case userNotExist = 10001 // 用户不存在
    case userPWDError       = 10002 // 用户密码错误
    case userNotLogin       = 10003 // 用户未登录
    case userOldPwdError    = 10007 // 用户旧密码错误

    case noLocation       = 3001 // 没有定位

    case noPath       = 4404 // 没有定位

    case phoneFormatTooShort       = 1001 // 手机号太短
    case phoneFormatWrong          = 1002 // 手机号错误
    
    case pwdEnpty           = 1003 //密码为空
    case userRepeatPWDError = 1004 // 俩次密码不一致
    case pwdTooShort        = 1007  //密码长度过短
    
    case nicknameTooLong    = 1014 //用户名过长
    case nicknameEmpty      = 1015 //用户名为空
    

    case userTokenError     = 10999 // 用户授权Token为空
    case tokenOverdue       = 10008 //用户授权Token过期
    case tokenInvalid       = 10009 //用户授权Token无效
    
    case houseNoEmpty     = 1006  //门牌号为空
    case linkManTooLong     = 1008 //联系人姓名过长
    case linkManEmpty       = 1009 //联系人姓名为空
    
    case taskError          = 1010 //未选择服务类型
    case timeError          = 1011 //未选择上门时间
    case noMoney            = 1012 //没有输入赏金
    
    case textViewEmpty      = 1013 //各种输入为空
    
    // 短信相关
    case smsIPLimiter        = 10200
    case smsPhoneLimiter     = 10201
    case smsOneMinuteLimiter = 10202
    case smsCodeExpired      = 10203
    case smsCodeError        = 10005 // 验证码错误
    case smsSendTooFast       = 10004 // 验证码发送太快

    //sns
    case snsError               = 10300
    case snsWeChatCodeError     = 10301
    case snsWeChatUnionIDError  = 10302
    case snsHasAlreadyBindError = 10303
    
    func errorMessage() -> String{
        switch self {
        case .smsIPLimiter:
            return "短信ip受限"
        case .smsOneMinuteLimiter:
            return "短信1分钟受限"
        case .userPWDError:
            return "密码错误"
        case .userTokenError:
            return "用户授权Token无法解析"
        default:
            return defaultError
        }
    }
}
