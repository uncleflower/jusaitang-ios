//
//  TabBarViewController.swift
//  an-xin-bang
//
//  Created by Duona Zhou on 7/5/20.
//  Copyright © 2020 IdeThink Inc. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class TabBarViewController: UITabBarController {
    
    public let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.overrideUserInterfaceStyle = .light
        loadItems()
        
//        if try! DataManager.shared.didLoginObservable.value() == false {
//            let goLoginView = UIView(frame: CGRect(x: 0, y: 0, width: App.screenWidth, height: App.screenHeight))
//            view.addSubview(goLoginView)
//            let goLoginTap = UITapGestureRecognizer(target: self, action: #selector(goLogin))
//            goLoginView.addGestureRecognizer(goLoginTap)
//        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    func loadItems(){
//        let navi1 = UINavigationController(rootViewController: HomeViewController())
//        navi1.tabBarItem = UITabBarItem(title: "安心帮", image: UIImage(named: "tab_home")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "tab_home_highlight")?.withRenderingMode(.alwaysOriginal))
//        let navi2 = UINavigationController(rootViewController: OrdersPagingViewController())
//        navi2.tabBarItem = UITabBarItem(title: "订单", image: UIImage(named: "tab_order")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "tab_order_highlight")?.withRenderingMode(.alwaysOriginal))
//        let navi3 = UINavigationController(rootViewController: MineViewController())
//        navi3.tabBarItem = UITabBarItem(title: "我的", image: UIImage(named: "tab_mine")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "tab_mine_highlight")?.withRenderingMode(.alwaysOriginal))
//        self.viewControllers = [navi1, navi2, navi3]
//
//        self.tabBar.tintColor = UIColor(red: 0.13, green: 0.14, blue: 0.13, alpha: 1)
//
    }
    
}
