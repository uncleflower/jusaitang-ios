//
//  BaseViewController.swift
//  an-xin-bang
//
//  Created by Jiehao Zhang on 2020/7/3.
//  Copyright © 2020 IdeThink Inc. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class BaseViewController: UIViewController {

    lazy var navigationView : NavigationView = {
        let navi = NavigationView(frame: CGRect(x: 0, y: 0, width: App.screenWidth, height: App.navigationBarHeight + App.statusBarHeight))
        return navi
    }()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.modalPresentationStyle = .overFullScreen
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.modalPresentationStyle = .overFullScreen
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.overrideUserInterfaceStyle = .light
        self.navigationController?.navigationBar.isHidden = true 
        view.addSubview(self.navigationView)
        
        view.backgroundColor = .white
        
        setupUI()
        
        makeConstraints()
        
        bindViewModel()
        
        DispatchQueue.main.async { [weak self] in //去掉UITableView布局的警告
            self?.asyncBindViewModelWhenWithTableView()
        }
        if (self.navigationController?.viewControllers.count ?? 0) == 1 {
            (self.navigationView.leftView as? UIButton)?.setImage(nil, for: .normal)
        }
    }
    override var title: String? {
        willSet {
            self.navigationView.titleLabel.text = newValue
        }
    }
    
    deinit {
        print("\(String(describing: self)) deinit")
    }
    // 以下方法交由子类去覆写
    func setupUI() { }
    
    func makeConstraints() { }
    // 没有TableView数据的绑定可以直接走这个
    func bindViewModel() { }
    // 当有UITableView的时候异步完成数据的绑定
    func asyncBindViewModelWhenWithTableView() {}

}

