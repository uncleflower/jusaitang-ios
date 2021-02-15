//
//  App.swift
//  UWatChat
//
//  Created by Don.shen on 2020/5/14.
//  Copyright © 2020 IdeThink Inc. All rights reserved.
//

import Foundation
import UIKit
import AdSupport

var debugModel = false

public struct App {
    public static var appName: String {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as! String
    }
    
    public static var appShortVersion: String {
        return Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
    }
    
    public static var appVersion: String{
        return Bundle.main.infoDictionary!["CFBundleVersion"] as! String
    }
    
    public static var appBuild: String {
        return Bundle.main.object(forInfoDictionaryKey: kCFBundleVersionKey as String) as! String
    }
    
    public static var bundleIdentifier: String {
        return Bundle.main.infoDictionary!["CFBundleIdentifier"] as! String
    }
    
    public static var bundleName: String {
        return Bundle.main.infoDictionary!["CFBundleName"] as! String
    }
    
    public static var appStoreURL: URL {
        return URL(string: "your URL")!
    }
    
    public static var appVersionAndBuild: String {
        let version = appVersion, build = appBuild
        return version == build ? "v\(version)" : "v\(version)(\(build))"
    }
    
    public static var IDFA: String {
        return ASIdentifierManager.shared().advertisingIdentifier.uuidString
    }
    
    public static var IDFV: String {
        return UIDevice.current.identifierForVendor!.uuidString
    }
    
    public static var screenOrientation: UIInterfaceOrientation {
        return UIApplication.shared.statusBarOrientation
    }
    
    public static var screenStatusBarHeight: CGFloat {
        return UIApplication.shared.statusBarFrame.height
    }
    
    public static var screenWidth: CGFloat{
        return UIScreen.main.bounds.size.width
    }
    
    public static var screenHeight: CGFloat{
        return UIScreen.main.bounds.size.height
    }
    public static var statusBarHeight: CGFloat{
        return App.isX ? 44.0 : 20.0 // 处理statusBarHidden的情况
    }
    public static var systemStatusBarHeight: CGFloat {
        return UIApplication.shared.statusBarFrame.height
    }
    public static var navigationBarHeight: CGFloat{
        return 44.0
    }
    public static var tabBarHeight: CGFloat{
        return 44.0
    }
    public static var naviStatusHeight: CGFloat{
        return App.statusBarHeight + App.navigationBarHeight
    }
    public static var screenHeightWithoutStatusBar: CGFloat {
        if UIInterfaceOrientation.portrait.isPortrait{
            return UIScreen.main.bounds.size.height - screenStatusBarHeight
        } else {
            return UIScreen.main.bounds.size.width - screenStatusBarHeight
        }
    }
    public static var isX: Bool{
        if #available(iOS 11.0, *){
            return UIApplication.shared.keyWindow?.safeAreaInsets.bottom != 0
        }else{
            return false
        }
    }
    public static var safeAreaBottom: CGFloat{
        return isX ? 34.0 : 0.0
    }
    
    public static var navigationController: UINavigationController? = {
        if let tabVC = UIApplication.shared.windows.last?.rootViewController as? TabBarViewController, let viewController = tabVC.viewControllers?.last{
            let navigationController = viewController.navigationController
            if let navigationController = navigationController?.viewControllers.last?.presentedViewController as? UINavigationController{
                return navigationController
            }else{
                return navigationController
            }
        }
        else if let navigation = UIApplication.shared.keyWindow?.rootViewController as? UINavigationController{
            return navigation
        }
        else if let navigation = UIApplication.shared.keyWindow?.rootViewController?.navigationController{
            return navigation
        }else{
            return nil
        }
    }()
    
}
struct Platform {
    static let isSimulator: Bool = {
        var isSim = false
        #if arch(i386) || arch(x86_64)
        isSim = true
        #endif
        return isSim
    }()
}
