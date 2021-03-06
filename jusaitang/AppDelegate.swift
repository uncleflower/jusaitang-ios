//
//  AppDelegate.swift
//  jusaitang
//
//  Created by Jiehao Zhang on 2021/2/10.
//

import UIKit

let apiHost = "http://39.97.102.209:8999"
//let apiHost = "http://192.168.43.73:8999/competition"

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        window.backgroundColor = .white
        window.makeKeyAndVisible()
        
        if DataManager.shared.loggedIn {
            self.window?.rootViewController = UINavigationController.init(rootViewController: TabBarViewController())
            return true
        }
//        self.window?.rootViewController = UINavigationController.init(rootViewController: TabBarViewController())
        self.window?.rootViewController = UINavigationController.init(rootViewController: LoginWithPswVC())
        return true
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
    }

}

