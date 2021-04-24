//
//  TextAlertView.swift
//  jusaitang
//
//  Created by Jiehao Zhang on 2021/3/28.
//

import UIKit

class TextAlertView: UIView {
        
    let titleView: UILabel = {
        let view = UILabel()
        view.font = UIFont.pf_semibold(16)
        view.textAlignment = .center
        view.numberOfLines = 0
        view.textColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        return view
    }()
    
    let describtionView: TextViewWithPh = {
        let view = TextViewWithPh()
        view.placeholder = "请输入队伍描述..."
        view.placeholderColor = UIColor(hexString: "#C0C0C0")
        view.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10)
        view.backgroundColor = .white
        view.font = UIFont.pf_medium(14)
        view.textColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        return view
    }()
        
    let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    let containerView: UIView = {
        let view = UIView()
        view.cornerRadius = 5
        view.backgroundColor = .white
        return view
    }()
    
    let title: String?
    
    var alertActions: [AlertAction] = []
    
    var buttons: [UIButton] = []
    
    init(title: String? = nil) {
        self.title = title
        
        super.init(frame: CGRect(x: 0, y: 0, width: App.screenWidth, height: App.screenHeight))
        loadView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addError(alertAction: AlertAction){
        alertActions.append(alertAction)
    }
    
    func addDone(alertAction: AlertAction){
        alertActions.append(alertAction)
    }
    
    func addAction(alertAction: AlertAction) {
        alertActions.append(alertAction)
        let button = UIButton.init()
        
        button.backgroundColor = UIColor.default
        button.titleLabel?.textAlignment = .center
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.pf_semibold(14)
        button.cornerRadius = 10
        button.setTitle(alertAction.title, for: .normal)
        
        if buttons.count == 1 {
            buttons[0].backgroundColor = .white
            buttons[0].setTitleColor(UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1), for: .normal)
            buttons[0].borderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
            buttons[0].borderWidth = 1
        }
        
        button.addAction {
            alertAction.complete?()
        }
        containerView.addSubview(button)
        self.buttons.append(button)
    }
    
    func loadView(){
        addSubview(backgroundView)
        addSubview(containerView)
        
        containerView.addSubview(titleView)
        containerView.addSubview(describtionView)
        
        KeyboardManager.shared.didAppear = {
            let hideTap = UITapGestureRecognizer(target: self, action: #selector(self.hideKeyboard))
            self.addGestureRecognizer(hideTap)
        }
        KeyboardManager.shared.didDisappear = {
            self.removeGestureRecognizers()
        }
    }
    
    func makeConstraints(){
        backgroundView.frame = CGRect(x: 0, y: 0, width: App.screenWidth, height: App.screenHeight)
        
//        containerView.frame = CGRect(x: 0, y: 0, width: App.screenWidth-32, height: 350)
        
        containerView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.lessThanOrEqualTo(500)
        }
        
        var topView = self.containerView
//        if title != nil {
            titleView.snp.makeConstraints { make in
                make.top.equalTo(topView).offset(20)
                make.centerX.equalToSuperview()
                make.leading.equalToSuperview().offset(16)
                make.trailing.equalToSuperview().offset(-16)
                make.height.equalTo(22)
            }
            topView = titleView
//        }
        
        describtionView.snp.makeConstraints { (make) in
            make.top.equalTo(topView.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(100)
        }
        topView = describtionView
        
        let buttonWidth = buttons.count == 1 ? 311 : 150
        let buttonHeight:CGFloat = 44
        
        for index in 0 ..< self.buttons.count {
            let button = self.buttons[index]
            if index == 0 {
                button.snp.remakeConstraints { make in
                    make.top.equalTo(topView.snp.bottom).offset(25)
                    make.bottom.equalToSuperview().offset(-20)
                    make.leading.equalToSuperview().offset(16)
                    make.width.equalTo(buttonWidth)
                    make.height.equalTo(buttonHeight)
                }
                continue
            }
            
            button.snp.remakeConstraints { make in
                make.bottom.equalToSuperview().offset(-20)
                make.trailing.equalToSuperview().offset(-16)
                make.width.equalTo(buttonWidth)
                make.height.equalTo(buttonHeight)
            }
        }
    }
    
    func prepare(){
        self.alpha = 0
        backgroundView.alpha = 0
        if let title = title {
            titleView.text = title
        }
    }
    
    func show(){
        makeConstraints()
        prepare()
        let animations: (() -> Void) = {
            self.alpha = 1
            self.backgroundView.alpha = 0.3
        }
        backgroundView.backgroundColor = .black
        
        guard let window = UIApplication.shared.windows.first else {return}
        window.addSubview(self)
        
        UIView.animate(withDuration: 0.35, animations: animations)
    }
    
    @objc func dismiss(){
        let animations: (() -> Void) = {
            self.alpha = 0
        }
        
        let completion: ((Bool) -> Void) = {
            (_) in
            self.removeFromSuperview()
        }
        
        
        UIView.animate(withDuration: 0.35, animations: animations, completion: completion)
    }
    
    @objc func hideKeyboard() {
        self.endEditing(true)
    }
}
