//
//  LoginWithPswVC.swift
//  jusaitang
//
//  Created by Jiehao Zhang on 2021/2/10.
//

import UIKit
import RxSwift
import RxCocoa

class LoginWithPswVC: BaseViewController {
    
    private let disposeBag = DisposeBag()
    
    let viewModel: LoginWithPswVM = .init()
    
    let greetLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.pf_medium(24)
        label.text = "聚赛堂"
        label.textColor = UIColor(hexString: "#333333")
        return label
    }()
    
    let privacyPolicyButton: ClickableTextView = {
        let view = ClickableTextView()
        view.textContainer.maximumNumberOfLines = 5
        let attributedString = NSMutableAttributedString(string: "登录即表示同意聚赛堂用户协议和隐私政策",
                                                         attributes: [.foregroundColor: UIColor(hexString: "#666666")!, .font: UIFont.pf_medium(12)])
        guard let range1 = attributedString.string.range(of: "聚赛堂用户协议") else { // Range<String.Index>?
          return view
        }
        let convertedRange1 = NSRange(range1, in: attributedString.string)
        attributedString.addAttribute(.link, value: "", range: convertedRange1)
        
        guard let range2 = attributedString.string.range(of: "隐私政策") else {
          return view
        }
        let convertedRange2 = NSRange(range2, in: attributedString.string)
        attributedString.addAttribute(.link, value: "", range: convertedRange2)
        view.attributedText = attributedString
        return view
    }()
    
    let inputSIDView: InputBackgroundView = {
        let view = InputBackgroundView()
        view.setUp(placeholder: "请输入学号", isSecureTextEntry: false, keyboardType: .phonePad)
        return view
    }()
    
    let passwordTextField: InputBackgroundView = {
        let view = InputBackgroundView()
        view.setUp(placeholder: "请输入密码", isSecureTextEntry: true, keyboardType: .default)
        return view
    }()
    
    let errorMessage: UILabel = {
        let label = UILabel()
        label.font = UIFont.pf_medium(13)
        label.numberOfLines = 0
        label.textColor = UIColor(red: 0.97, green: 0.39, blue: 0.39, alpha: 1)
        return label
    }()
    
    let loginButton: UIButton = {
        let btn = UIButton()
        btn.layer.cornerRadius = 4
        btn.backgroundColor = .default
        btn.setTitle("登录", for: .normal)
        btn.titleLabel?.font = UIFont.pf_medium(14)
        btn.setTitleColor(.white, for: .normal)
        btn.setTitleColor(.red, for: .disabled)
        return btn
    }()
    
    override func loadView() {
        super.loadView()
        view.addSubview(greetLabel)
        view.addSubview(privacyPolicyButton)
        view.addSubview(inputSIDView)
        view.addSubview(passwordTextField)
        view.addSubview(errorMessage)
        view.addSubview(loginButton)
    }
    
    
    override func makeConstraints() {
        super.makeConstraints()
        
        greetLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(App.naviStatusHeight + 38)
            make.leading.equalToSuperview().offset(24)
            make.height.equalTo(33)
        }
        
        privacyPolicyButton.snp.makeConstraints { (make) in
            make.top.equalTo(greetLabel.snp.bottom).offset(8)
            make.leading.equalTo(greetLabel)
            make.height.equalTo(20)
            make.width.equalTo(300)
        }
        
        inputSIDView.snp.makeConstraints { (make) in
            make.top.equalTo(privacyPolicyButton.snp.bottom).offset(20)
            make.height.equalTo(42)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
        }
        
        
        passwordTextField.snp.makeConstraints { (make) in
            make.top.equalTo(inputSIDView.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(42)
        }
        
        errorMessage.snp.makeConstraints { (label) in
            label.top.equalTo(passwordTextField.snp.bottom).offset(8)
            label.leading.equalTo(greetLabel.snp.leading)
            label.height.equalTo(18)
        }
        
        loginButton.snp.makeConstraints { (btn) in
            btn.top.equalTo(errorMessage.snp.bottom).offset(27)
            btn.leading.equalTo(greetLabel.snp.leading)
            btn.height.equalTo(44)
            btn.trailing.equalToSuperview().offset(-24)
        }
    }
    
    override func bindViewModel() {
        
        inputSIDView.textField.rx.text.orEmpty.subscribe(onNext: {[weak self] (sid) in
            self?.viewModel.sIDObservable.onNext(sid)
            if sid.count == 0 {
                self?.errorMessage.text = ""
            }
        }).disposed(by: disposeBag)

        passwordTextField.textField.rx.text.orEmpty.subscribe(onNext: {[weak self] (pwd) in
            self?.viewModel.pwdObservable.onNext(pwd)
            if pwd.count == 0 {
                self?.errorMessage.text = ""
            }
        }).disposed(by: disposeBag)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        self.view.addGestureRecognizer(tapGesture)
        self.loginButton.addTarget(self, action: #selector(loginWithPwd), for: .touchUpInside)
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
    @objc func loginWithPwd() {
        self.view.endEditing(true)
        let error = self.viewModel.loginWithPwd {[weak self] (error) in
            if let error = error  {
                if error.code == .userNotExist {
                    self?.errorMessage.text = "该学号不存在"
                } else if error.code == .userPWDError {
                    self?.errorMessage.text = "密码错误，请重新输入"
                } else {
                    ErrorAlertView.show(error: error, style: .topError)
                }
                return
            }
            
            self?.goTabBarView()
        }
        if let error = error {
            if error.code == .sidEmpty {
                self.errorMessage.text = "学号不能为空"
            } else if error.code == .pwdEnpty {
                self.errorMessage.text = "密码不能为空"
            }
        }
    }
    
    func goTabBarView() {
        self.navigationController?.pushViewController(TabBarViewController(), animated: true)
    }

}

