//
//  AppDelegate.swift
//  jusaitang
//
//  Created by Jiehao Zhang on 2021/2/10.
//

import UIKit

let apiHost = "https://www.tracys.cn/jusaitang"
let imageHost = "https://www.tracys.cn"

let wechatID = "wx0c508bf9d425c4f4"

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        window.backgroundColor = .white
        window.makeKeyAndVisible()
        
        if DataManager.shared.loggedIn {
            self.window?.rootViewController = UINavigationController.init(rootViewController: TabBarViewController())
            return true
        }
        self.window?.rootViewController = UINavigationController.init(rootViewController: LoginWithPswVC())
//        self.window?.rootViewController = UINavigationController.init(rootViewController: TabBarViewController())
                
        WXApi.registerApp(wechatID, universalLink: "https://www.tracys.cn/")
        WXApi.startLog(by: .normal, logDelegate: self)
        
        return true
    }
}

extension AppDelegate: WXApiDelegate, WXApiLogDelegate {
//    func onResp(_ resp: BaseResp) {
//        //TODO 微信支付
////        print("WX: \(#function), resp = \(resp)")
//        if let authResp = resp as? SendAuthResp {
//            if authResp.errCode == WXSuccess.rawValue {
//                let code = authResp.code
//                NotificationCenter.default.post(name: .wxDidLogedeIn, object: code)
//            }
//        }
//    }
//
    func onLog(_ log: String, logLevel level: WXLogLevel) {
        print("WX: onLog = \(log)")
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        let handleUrlStr = url.absoluteString
        if let handleUrl = URL(string: handleUrlStr) {
            return WXApi.handleOpen(handleUrl, delegate: self)
        }
        return false
    }
    
    func application(_ application: UIApplication, handleOpen url: URL) -> Bool {
        let handleUrlStr = url.absoluteString
        if let handleUrl = URL(string: handleUrlStr) {
            return WXApi.handleOpen(handleUrl, delegate: self)
        }
        return false
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        let handleUrlStr = url.absoluteString
        if let handleUrl = URL(string: handleUrlStr) {
            return WXApi.handleOpen(handleUrl, delegate: self)
        }
        return false
    }
    
    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        return WXApi.handleOpenUniversalLink(userActivity, delegate: self)
    }
}

