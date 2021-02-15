//
//  AppDelegate.swift
//  jusaitang
//
//  Created by Jiehao Zhang on 2021/2/10.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        window.backgroundColor = .white
        window.makeKeyAndVisible()
        
        self.window?.rootViewController = UINavigationController.init(rootViewController: ViewController())
        return true
    }

}

