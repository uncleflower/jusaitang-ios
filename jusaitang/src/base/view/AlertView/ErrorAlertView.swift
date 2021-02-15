//
//  AlertView.swift
//  an-xin-bang
//
//  Created by Duona Zhou on 7/5/20.
//  Copyright © 2020 IdeThink Inc. All rights reserved.
//

import UIKit

enum TitleAlertViewStyle {
    case center
    case topError
}



enum ErrorAlertViewStyle {
    case center
    case topError
}
class ErrorAlertView: UIView  {
    
    let style: ErrorAlertViewStyle
    
    static func show(message:String?, style:TitleAlertViewStyle){
        guard let window = UIApplication.shared.windows.first else {return}
        let AlertView = ErrorAlertView(message: message, style: .topError)
        AlertView.frame = CGRect(x: 0, y: 0, width: App.screenWidth, height: 88)
        AlertView.backgroundColor = UIColor(hexString: "#FFF4F4")
        window.addSubview(AlertView)
        AlertView.show()
    }
    
    static func show(error:Error?, style:ErrorAlertViewStyle = .topError){
        guard let error = error else {return}
        
        var title = ""
        
        if let error = error as? IError, let message = error.message{
            title = message
        }
        
        guard let window = UIApplication.shared.windows.first else {return}
        let AlertView = ErrorAlertView(message: title, style: .topError)
        AlertView.frame = CGRect(x: 0, y: 0, width: App.screenWidth, height: 88)
        AlertView.backgroundColor = UIColor(hexString: "#FFF4F4")
        window.addSubview(AlertView)
        AlertView.show()
    }
    
    let titleView: UILabel = {
        let titleView = UILabel()
        return titleView
    }()
    
    init(message:String?, style: ErrorAlertViewStyle = .center) {
        self.style = style
        super.init(frame: .zero)
        titleView.text = message
        titleView.textAlignment = .center
        addSubview(titleView)
        
        switch style {
        case .topError:
            titleView.font = .pf_medium(15)
            titleView.textColor = UIColor(hexString: "#FF5454")
            makeTopStyleConstraints()
            break
        case .center:
//            makeCenterStyleConstraints()
            break
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeTopStyleConstraints(){
        titleView.snp.makeConstraints { (label) in
            label.top.equalToSuperview().offset(44)
            label.height.equalTo(44)
            label.leading.equalToSuperview()
            label.trailing.equalToSuperview()
        }
    }
    
    func makeCenterStyleConstraints(){
        titleView.sizeToFit()
        titleView.frame.size.width += 20
        titleView.frame.size.height += 20
        titleView.snp.makeConstraints { (label) in
            label.top.equalToSuperview().offset(124)
            label.leading.equalToSuperview().offset(40)
        }
    }

    func prepare(){
        switch style {
        case .center:
        self.alpha = 0
            break
        case .topError:
            self.frame.origin.y = -44
            self.alpha = 0
            break
        }
    }
    
    func show(){
        prepare()
        let animations: (() -> Void)
        
        switch style {
        case .center:
            animations = {
                self.alpha = 1
            }
            break
        case .topError:
            animations = {
                self.frame.origin.y = 0
                self.alpha = 1
            }
            break
        }
    
        
        UIView.animate(withDuration: 0.35, animations: animations){
            (_) in
            self.perform(#selector(self.dismiss), with: nil, afterDelay: 2)
        }
    }
    
    @objc func dismiss(){
        let animations: (() -> Void)
        
        let completion: ((Bool) -> Void) = {
            (_) in
            self.removeFromSuperview()
        }
        
        switch style {
        case .center:
            animations = {
                self.alpha = 0
            }
            break
        case .topError:
            animations = {
                self.frame.origin.y = -44
                self.alpha = 0
            }
            break
        }
    
        
        UIView.animate(withDuration: 0.35, animations: animations, completion: completion)
    }
}
