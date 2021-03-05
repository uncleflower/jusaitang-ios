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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    func loadItems(){
        let navi1 = UINavigationController(rootViewController: CompetitionCenterVC())
        navi1.tabBarItem = UITabBarItem(title: "竞赛中心", image: UIImage(systemName: "crown")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(systemName: "crown.fill")?.withTintColor(.default, renderingMode: .alwaysOriginal))
        let navi2 = UINavigationController(rootViewController: TeamPagingViewController())
        navi2.tabBarItem = UITabBarItem(title: "组队", image: UIImage(systemName: "flag")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(systemName: "flag.fill")?.withTintColor(.default, renderingMode: .alwaysOriginal))
        let navi3 = UINavigationController(rootViewController: UserCenterVC())
        navi3.tabBarItem = UITabBarItem(title: "我的", image: UIImage(systemName: "person")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(systemName: "person.fill")?.withTintColor(.default, renderingMode: .alwaysOriginal))
        self.viewControllers = [navi1, navi2, navi3]
        
        self.tabBar.tintColor = UIColor(red: 0.13, green: 0.14, blue: 0.13, alpha: 1)
    }
    
}
