//
//  NotificationExtension.swift
//  an-xin-bang
//
//  Created by Duona Zhou on 7/24/20.
//  Copyright © 2020 IdeThink Inc. All rights reserved.
//

import Foundation

// 这里作为自定义通知的统一管理类

extension Notification.Name{
    /// 无效令牌
    static let invalidToken = Notification.Name("login.InvalidToken")
    /// 登录成功
    static let didLogin  = Notification.Name("chat.didLogin")
    /// 退出登录
    static let didLogOut = Notification.Name("chat.didLogOut")
    /// 登录成功
    static let logedInSuccess = Notification.Name("chat.logedInSuccess")
    
    static let wxDidLogedeIn = Notification.Name("wx.logedIn.notificaiton")
    /// 三方登录绑定用户信息
    static let bindNewbie = Notification.Name("wx.bindNewbie.notificaiton")
}
