//
//  AlertView.swift
//  an-xin-bang
//
//  Created by Duona Zhou on 7/18/20.
//  Copyright © 2020 IdeThink Inc. All rights reserved.
//

import UIKit

enum AlertActionType{
    case none;
    case done;
    case error;
    case cancel;
}

class AlertAction: NSObject{
    
    var type:AlertActionType = .none
    
    var complete: (() -> Void)?
    
    var title: String?
    
    init(type: AlertActionType, complete: (() -> ())? = nil) {
        self.type = type
        self.complete = complete
        super.init()
    }
    
}

class AlertView: UIView {
        
    let titleView: UILabel = {
        let view = UILabel()
        view.font = UIFont.pf_semibold(16)
        view.textAlignment = .center
        view.numberOfLines = 0
        view.textColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        return view
    }()
        
    let subTitleView: UILabel = {
        let view = UILabel()
        view.font = UIFont.pf_semibold(16)
        view.textAlignment = .center
        view.numberOfLines = 0
        view.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        return view
    }()
        
    let detailView: UILabel = {
        let view = UILabel()
        view.font = UIFont.pf_medium(16)
        view.textAlignment = .center
        view.numberOfLines = 0
        view.textColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        return view
    }()
        
    let subDetailView: UILabel = {
        let view = UILabel()
        view.font = UIFont.pf_medium(16)
        view.textAlignment = .center
        view.numberOfLines = 0
        view.textColor = UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 1)
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
    
    let subTitle:String?
    
    let detail:String?
    
    let subDetail:String?
    
    var alertActions: [AlertAction] = []
    
    var buttons: [UIButton] = []
    
    init(title: String? = nil, subTitle: String? = nil, detail:String? = nil ,subDetail: String? = nil) {
        self.title = title
        self.detail = detail
        self.subTitle = subTitle
        self.subDetail = subDetail
        
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
        containerView.addSubview(subTitleView)
        containerView.addSubview(detailView)
        containerView.addSubview(subDetailView)
    }
    
    func makeConstraints(){
        backgroundView.frame = CGRect(x: 0, y: 0, width: App.screenWidth, height: App.screenHeight)
        
//        containerView.frame = CGRect(x: 0, y: 0, width: App.screenWidth-32, height: 350)
        
        containerView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.lessThanOrEqualTo(350)
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
        
        if subTitle != nil {
            subTitleView.snp.remakeConstraints { make in
                make.top.equalTo(topView.snp.bottom).offset(16)
                make.leading.equalToSuperview().offset(16)
                make.trailing.equalToSuperview().offset(-16)
                make.height.lessThanOrEqualTo(70)
            }
            topView = subTitleView
        }
        
        if detail != nil{
            detailView.snp.remakeConstraints { make in
                make.top.equalTo(topView.snp.bottom).offset(16)
                make.leading.equalToSuperview().offset(16)
                make.trailing.equalToSuperview().offset(-16)
                make.height.lessThanOrEqualTo(70)
            }
            topView = detailView
        }
        
        if subDetail != nil{
            subDetailView.snp.remakeConstraints { make in
                make.top.equalTo(topView.snp.bottom).offset(16)
                make.leading.equalToSuperview().offset(16)
                make.trailing.equalToSuperview().offset(-16)
                make.height.lessThanOrEqualTo(70)
            }
            topView = subDetailView
        }
        
        
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
        if let subTitle = subTitle {
            subTitleView.text = subTitle
        }
        if let detail = detail {
            detailView.text = detail
        }
        if let subDetail = subDetail {
            subDetailView.text = subDetail
        }
    }
    
    func show(){
        makeConstraints()
        prepare()
        let animations: (() -> Void) = {
            self.alpha = 1
            self.backgroundView.alpha = 0.3
        }
        //        self.backgroundColor = .black
        backgroundView.backgroundColor = .black
        
        guard let window = UIApplication.shared.windows.first else {return}
        window.addSubview(self)
        
        UIView.animate(withDuration: 0.35, animations: animations){
            (_) in
            //            self.perform(#selector(self.dismiss), with: nil, afterDelay: 2)
        }
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
}
