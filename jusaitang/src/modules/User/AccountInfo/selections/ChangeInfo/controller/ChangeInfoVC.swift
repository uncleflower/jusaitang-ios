//
//  ChangeInfoVC.swift
//  jusaitang
//
//  Created by Jiehao Zhang on 2021/3/4.
//

import UIKit
import RxSwift
import RxCocoa

enum ChangeInfoType: Int {
    case unknown = -1
    case phone = 0
    case email = 1
}

class ChangeInfoVC: BaseViewController {
    
    private let disposeBag = DisposeBag()
    
    var viewModel: ChangeInfoVM = ChangeInfoVM.init()
    
    var completion: ((String) -> Void)? = nil
    
    var type: ChangeInfoType!
            
    let dismissBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "dismiss_arrow"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        return btn
    }()
    
    let inputInfoView: InputWithBar = {
        let view = InputWithBar()
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
        
        view.addSubview(inputInfoView)
        view.addSubview(finishBtn)
    }
    
    init(old: String, type: ChangeInfoType) {
        super.init(nibName: nil, bundle: nil)
        self.type = type
        setContent(info: old)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func makeConstraints() {
        super.makeConstraints()
        
        inputInfoView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(App.naviStatusHeight)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(55)
        }
        
        finishBtn.snp.makeConstraints { (make) in
            make.top.equalTo(inputInfoView.snp.bottom).offset(30)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(44)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 0.97, green: 0.97, blue: 0.97, alpha: 1)
        
        self.navigationView.backgroundColor = .white
        self.navigationView.leftView = dismissBtn
        self.navigationView.titleLabel.textColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        self.navigationView.titleLabel.font = UIFont.pf_medium(16)
        dismissBtn.addTarget(self, action: #selector(popView), for: .touchUpInside)
        
        if type == .phone {
            self.navigationView.titleLabel.text = "修改手机号"
            finishBtn.addTarget(self, action: #selector(changePhone), for: .touchUpInside)
        } else if type == .email {
            self.navigationView.titleLabel.text = "修改邮箱"
            finishBtn.addTarget(self, action: #selector(changeEmail), for: .touchUpInside)
        }
    }
    
    @objc func changePhone() {
        guard let phone = inputInfoView.inputTextField.text else {return}
        
        if phone.removeAllSpace().isEmpty  {
            let alert = SlightAlert(title: "输入不能为空")
            alert.show()
        }
        
        let error = viewModel.changeInfo(phone: phone) {[weak self] (error) in
            if let error = error {
                ErrorAlertView.show(error: error, style: .topError)
                return
            }
            self?.completion!(phone)
            self?.popView()
        }
        
        if let error = error {
            if error.code == .phoneFormatWrong {
                let alert = SlightAlert(title: "手机号格式不正确")
                alert.show()
            }
        }
    }
    
    @objc func changeEmail() {
        guard let email = inputInfoView.inputTextField.text else {return}
        
        if email.removeAllSpace().isEmpty  {
            let alert = SlightAlert(title: "输入不能为空")
            alert.show()
            return
        }
        
        let error = viewModel.changeInfo(email: email) {[weak self] (error) in
            if let error = error {
                ErrorAlertView.show(error: error, style: .topError)
                return
            }
            self?.completion!(email)
            self?.popView()
        }
        
        if let error = error {
            //TODO: email valid
//            if error.code == .nicknameTooLong {
//                let alert = SlightAlert(title: "最多输入16个字哦")
//                alert.show()
//            }
        }
    }
    
    @objc func popView() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func setContent(info: String) {
        var placeholder = ""
        if type == .phone {
            inputInfoView.titleLabel.text = "手机号"
            placeholder = "请输入手机号"
        } else {
            inputInfoView.titleLabel.text = "邮箱"
            placeholder = "请输入邮箱"
        }
        
        let str = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor:UIColor(hexString: "#BBBBBB")!,NSAttributedString.Key.font:UIFont.pf_medium(14)])
        inputInfoView.inputTextField.attributedPlaceholder = str
        inputInfoView.inputTextField.keyboardType = .default
        inputInfoView.inputTextField.text = info
        
        inputInfoView.inputTextField.snp.updateConstraints { (make) in
            make.leading.equalToSuperview().offset(74)
        }
    }
}
