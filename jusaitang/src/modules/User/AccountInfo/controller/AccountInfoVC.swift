//
//  AccountInfoVC.swift
//  jusaitang
//
//  Created by Jiehao Zhang on 2021/3/4.
//

import UIKit
import RxSwift
import RxCocoa

class AccountInfoVC: BaseViewController {
    
    private let disposeBag = DisposeBag()
    
    let viewModel: AccountInfoVM = .init()
    
    var completion: ((User?) -> Void)? = nil
    
    var tableView: UITableView!
    
    let logoutBkg: UIButton = {
        var view = UIButton()
        view.backgroundColor = .white
        return view
    }()
    
    let logoutLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.pf_medium(14)
        view.text = "退出登录"
        view.textColor = UIColor(red: 1, green: 0.27, blue: 0.27, alpha: 1)
        return view
    }()
    
    let dismissButon: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "dismiss_arrow"), for: .normal)
        btn.contentMode = .center
        btn.imageView?.contentMode = .scaleAspectFit
        return btn
    }()
    
    override func loadView() {
        super.loadView()
        
        tableView = BaseTableView.init(frame: self.view.frame,style: .plain)
        tableView.backgroundColor = UIColor(red: 0.97, green: 0.97, blue: 0.97, alpha: 1)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.contentInset = UIEdgeInsets.init(top: App.naviStatusHeight, left: 0, bottom: 0, right: 0)
        tableView.isScrollEnabled = false
        tableView.separatorStyle = .none
        tableView.register(AvatarCell.self, forCellReuseIdentifier: "AvatarCell")
        tableView.register(AccountInfoCell.self, forCellReuseIdentifier: "AccountInfoCell")
        view.addSubview(tableView)
        
        
        view.addSubview(logoutBkg)
        view.addSubview(logoutLabel)
    }
    
    override func makeConstraints() {
        super.makeConstraints()
        
        logoutBkg.snp.makeConstraints { (make) in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(74)
        }
        
        logoutLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-44)
            make.height.equalTo(20)
            make.width.equalTo(60)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationView.backgroundColor = .white
        self.navigationView.leftView = dismissButon
        dismissButon.addTarget(self, action: #selector(popView), for: .touchUpInside)
        self.navigationView.titleLabel.text = "账号信息"
        self.navigationView.titleLabel.font = UIFont.pf_medium(16)
        self.navigationView.titleLabel.textColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        
        logoutBkg.addTarget(self, action: #selector(logout), for: .touchUpInside)
        
        DataManager.shared.userObservable.subscribe(onNext: {[weak self] (user) in
            self?.viewModel.userInfo.onNext(user)
        }).disposed(by: disposeBag)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.removeObserver(self, name: .wxDidLogedeIn, object: nil)
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
                
                _ = DataManager.shared.clearUser()
                _ = DataManager.shared.clearToken()
                self.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(LoginWithPswVC(), animated: true)
            }
            alert.dismiss()
        }
        aciont2.title = "确定"
        alert.addAction(alertAction: aciont2)
        alert.show()
    }
    
    @objc func popView() {
        completion?(try? self.viewModel.userInfo.value())
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension AccountInfoVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.item == 0 {
            return 70
        }
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let userInfo = try? self.viewModel.userInfo.value() else {return}
        let vm = viewModel.accountInfoCellVMs[indexPath.item]
        if indexPath.row == 0 {
            let changeAvatarView = ChangeAvatarView(frame: CGRect(x: 0, y: 0, width: App.screenWidth, height: App.screenHeight))
            changeAvatarView.show {
                [weak self] (image) in
                guard let image = image else {return}
                self?.changeAvatar(image: image)
            }
        } else if indexPath.row == 3 {
            let vc = ChangePwdVC()
            self.navigationController?.pushViewController(vc, animated: true)
        } else if indexPath.row == 4 {
            var oldPhone = ""
            if userInfo.phone != "" {
                oldPhone = try! vm.infoObservable.value()
            }
            let vc = ChangeInfoVC.init(old: oldPhone, type: .phone)
            vc.completion = {
                newPhone in
                let user = DataManager.shared.user
                user?.phone = newPhone
                DataManager.shared.user = user
            }
            self.navigationController?.pushViewController(vc, animated: true)
        } else if indexPath.row == 5 {
            var oldEmail = ""
            if userInfo.email != "" {
                oldEmail = try! vm.infoObservable.value()
            }
            let vc = ChangeInfoVC.init(old: oldEmail, type: .email)
            vc.completion = {
                newEmail in
                let user = DataManager.shared.user
                user?.email = newEmail
                DataManager.shared.user = user
            }
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func changeAvatar(image:UIImage){
//        let activity = ActivityIndicatorView.show(title: "正在上传", style: .fullScreen)
//        let imageData = image.jpegData(compressionQuality: 0.1) ?? Data()
//        CommonAPI.uploadImage(image: UIImage(data: imageData)!.fixOrientation(), path: "avatar") {(res, error) in
//            if let error = error {
//                ErrorAlertView.show(error: error, style: .topError)
//                return
//            }
//            guard let res = res else {return}
//            let req = MineAPI.ChangeNameOrAvatarReq()
//            req.avatar = res.url
//            MineAPI.changeNameOrAvatar(request: req) { (error) in
//                if let error = error {
//                    ErrorAlertView.show(error: error, style: .topError)
//                    return
//                }
//                activity?.dismiss()
//                let user = DataManager.shared.user
//                user?.avatar = res.url
//                DataManager.shared.user = user
//            }
//        }
    }
}

extension AccountInfoVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.accountInfoCellVMs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let vm = viewModel.accountInfoCellVMs[indexPath.item]
        if indexPath.item == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AvatarCell", for: indexPath) as! AvatarCell
            cell.bindViewModel(viewModel: vm)
            cell.selectionStyle = .none
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "AccountInfoCell", for: indexPath) as! AccountInfoCell
        if indexPath.item == 1 || indexPath.item == 2 {
            cell.arrowView.isHidden = true
        }
        cell.bindViewModel(viewModel: vm)
        cell.selectionStyle = .none
        return cell
    }
    
    
}
