//
//  UserCenterVC.swift
//  jusaitang
//
//  Created by Jiehao Zhang on 2021/3/2.
//

import UIKit
import RxSwift
import RxCocoa

class UserCenterVC: BaseViewController {
    
    let logoutButton: UIButton = {
        let view = UIButton()
        view.setTitle("退出登录", for: .normal)
        view.setTitleColor(UIColor(hexString: "#333333"), for: .normal)
        view.titleLabel?.font = UIFont.pf_semibold(24)
        return view
    }()
    
    private let disposeBag = DisposeBag()
    
    override func loadView() {
        super.loadView()
        
        view.addSubview(logoutButton)
    }
    
    override func makeConstraints() {
        super.makeConstraints()
        
        logoutButton.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        logoutButton.addTarget(self, action: #selector(logout), for: .touchUpInside)
    }
    
    @objc func logout() {
        let alert = AlertView(title: "确认退出？", detail: "退出登录后将无法查看比赛信息，重新登录后即可查看")
        let aciont1 = AlertAction(type: .none) {
            alert.dismiss()
        }
        aciont1.title = "取消"
        alert.addAction(alertAction: aciont1)
        let aciont2 = AlertAction(type: .none) {
            LoginAPI.logout(request: EmptyReq()) { (res, error) in
                if let error = error {
                    ErrorAlertView.show(error: error, style: .topError)
                    return
                }
                
                self.hidesBottomBarWhenPushed = true
                self.navigationController?.setViewControllers([LoginWithPswVC()], animated: true)
            }
            alert.dismiss()
        }
        aciont2.title = "确定"
        alert.addAction(alertAction: aciont2)
        alert.show()
    }
}
