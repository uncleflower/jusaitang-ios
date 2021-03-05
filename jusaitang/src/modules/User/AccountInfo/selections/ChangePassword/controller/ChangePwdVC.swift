//
//  ChangePwdVC.swift
//  jusaitang
//
//  Created by Jiehao Zhang on 2021/3/4.
//

import UIKit
import RxSwift
import RxCocoa

class ChangePwdVC: BaseViewController {
        
    private let disposeBag = DisposeBag()
    
    let viewModel = ChangePwdVM.init()
    
    let dismissBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "dismiss_arrow"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        return btn
    }()
    
    let oldPwdView: InputWithBar = {
        let view = InputWithBar()
        return view
    }()
    
    let newPwdView: InputWithBar = {
        let view = InputWithBar()
        return view
    }()
    
    let checkPwdView: InputWithLine = {
        let view = InputWithLine()
        return view
    }()
    
    let errorMessage: UILabel = {
        let view = UILabel()
        view.font = UIFont.pf_regular(13)
        view.numberOfLines = 0
        view.textColor = UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 1)
        view.text = "密码长度6位以上，包含数字、字母、符号"
        return view
    }()
    
    let finishBtn: UIButton = {
        let btn = UIButton()
        btn.cornerRadius = 10
        btn.setTitle("完成", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont.pf_semibold(14)
        btn.backgroundColor = UIColor.default
        return btn
    }()
    
    override func loadView() {
        super.loadView()
        
        view.addSubview(oldPwdView)
        view.addSubview(newPwdView)
        view.addSubview(checkPwdView)
        view.addSubview(errorMessage)
        view.addSubview(finishBtn)
        
        setContent()
    }
    
    override func makeConstraints() {
        super.makeConstraints()
        
        oldPwdView.snp.makeConstraints { (make) in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalToSuperview().offset(App.naviStatusHeight)
            make.height.equalTo(55)
        }
        
        newPwdView.snp.makeConstraints { (make) in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalTo(oldPwdView.snp.bottom)
            make.height.equalTo(55)
        }
        
        checkPwdView.snp.makeConstraints { (make) in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalTo(newPwdView.snp.bottom)
            make.height.equalTo(50)
        }
        
        errorMessage.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview()
            make.top.equalTo(checkPwdView.snp.bottom).offset(5)
            make.height.equalTo(18)
        }
        
        finishBtn.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalTo(errorMessage.snp.bottom).offset(30)
            make.height.equalTo(44)
        }
    }
    
    override func bindViewModel() {
        oldPwdView.inputTextField.rx.text.orEmpty.subscribe(onNext: {[weak self] (pwd) in
            self?.viewModel.oldPwdObservable.onNext(pwd)
        }).disposed(by: disposeBag)
        newPwdView.inputTextField.rx.text.orEmpty.subscribe(onNext: {[weak self] (pwd) in
            self?.viewModel.newPwdObservable.onNext(pwd)
        }).disposed(by: disposeBag)
        checkPwdView.inputTextField.rx.text.orEmpty.subscribe(onNext: {[weak self] (pwd) in
            self?.viewModel.checkPwdObservable.onNext(pwd)
        }).disposed(by: disposeBag)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 0.97, green: 0.97, blue: 0.97, alpha: 1)
        
        self.navigationView.backgroundColor = .white
        self.navigationView.leftView = dismissBtn
        self.navigationView.titleLabel.text = "修改密码"
        self.navigationView.titleLabel.textColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        self.navigationView.titleLabel.font = UIFont.pf_medium(16)
        dismissBtn.addTarget(self, action: #selector(popView), for: .touchUpInside)
        finishBtn.addTarget(self, action: #selector(changePwd), for: .touchUpInside)
    }
    
    @objc func popView() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func changePwd() {
        let error = viewModel.changePwd {[weak self] (error) in
            if let error = error {
                self?.errorMessage.textColor = UIColor(red: 0.98, green: 0.4, blue: 0.4, alpha: 1)
                if error.code == .userPWDError {
                    self?.errorMessage.text = "旧密码输入错误"
                }
                return
            }
            SlightAlert(title: "密码修改成功", image: "slight_alert_tick").show()
            self?.popView()
        }
        if let error = error {
            errorMessage.textColor = UIColor(red: 0.98, green: 0.4, blue: 0.4, alpha: 1)
            if error.code == .pwdEnpty {
                self.errorMessage.text = "密码不能为空"
            } else if error.code == .pwdTooShort {
                self.errorMessage.text = "密码必须是6位以上的英文字母、数字、字符"
            } else if error.code == .userRepeatPWDError {
                self.errorMessage.text = "两次密码输入不一致"
            }
        } else {
            errorMessage.textColor = UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 1)
            errorMessage.text = "密码长度6位以上，包含数字、字母、符号"
        }
    }
    
    func setContent() {
        oldPwdView.titleLabel.text = "旧密码"
        newPwdView.titleLabel.text = "新密码"
        checkPwdView.titleLabel.text = "确认密码"
        
        let str1 = NSAttributedString(string: "请输入密码", attributes: [NSAttributedString.Key.foregroundColor:UIColor(hexString: "#BBBBBB")!,NSAttributedString.Key.font:UIFont.pf_medium(14)])
        let str2 = NSAttributedString(string: "请输入新的密码", attributes: [NSAttributedString.Key.foregroundColor:UIColor(hexString: "#BBBBBB")!,NSAttributedString.Key.font:UIFont.pf_medium(14)])
        let str3 = NSAttributedString(string: "请再次确认密码", attributes: [NSAttributedString.Key.foregroundColor:UIColor(hexString: "#BBBBBB")!,NSAttributedString.Key.font:UIFont.pf_medium(14)])
        oldPwdView.inputTextField.attributedPlaceholder = str1
        oldPwdView.inputTextField.isSecureTextEntry = true
        newPwdView.inputTextField.attributedPlaceholder = str2
        newPwdView.inputTextField.isSecureTextEntry = true
        checkPwdView.inputTextField.attributedPlaceholder = str3
        checkPwdView.inputTextField.isSecureTextEntry = true
    }
}
