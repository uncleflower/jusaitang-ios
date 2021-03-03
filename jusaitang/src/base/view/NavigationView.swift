//
//  NavigationView.swift
//  UWatChat
//
//  Created by Don.shen on 2020/5/15.
//  Copyright © 2020 IdeThink Inc. All rights reserved.
//

import UIKit
import SnapKit

/// 自定义导航View, 左滑导航栏跟随的问题

class NavigationView: UIView {
    
    var containerView: UIView = UIView()
    
    private var _leftView:UIView?
    var leftView:UIView?{
        get{
            if _leftView == nil{
                _leftView =  UIButton(type: .custom)
            }
            return _leftView;
        }
        set(newValue){
            if _leftView != nil{
                _leftView?.removeFromSuperview()
            }
            _leftView = newValue
            if let _leftView = _leftView{
                self.addSubview(_leftView)
                _leftView.snp.remakeConstraints { make in
                    make.leading.equalTo(containerView)
                    make.centerY.equalTo(containerView)
                    make.width.lessThanOrEqualTo(200)
                    make.width.greaterThanOrEqualTo(40)
                    make.height.equalTo(40.0)
                }
            }
        }
        
    }
    
    
    lazy var titleLabel : UILabel = {
        let title =  UILabel()
        title.textColor = UIColor(hexString: "#333333")
        title.font = UIFont.pf_medium(18)
        title.textAlignment = .center
        return title
    }()
    
    private var _centerView:UIView?
    var centerView:UIView? {
        get{
            if _centerView == nil{
                _centerView =  UIButton(type: .custom)
            }
            return _centerView;
        }
        set(newValue){
            if _centerView != nil{
                _centerView?.removeFromSuperview()
            }
            _centerView = newValue
            if let _centerView = _centerView{
                self.addSubview(_centerView)
                _centerView.snp.remakeConstraints { make in
                    make.centerY.equalTo(containerView)
                    make.leading.equalToSuperview().offset(40.0)
                    make.trailing.equalToSuperview().offset(-40.0)
                }
            }
        }
    }

    
    private var _rigthView:UIView?
    var rightView:UIView? {
        get{
            if _rigthView == nil{
                _rigthView =  UIButton(type: .custom)
            }
            return _rigthView;
        }
        set(newValue){
            if _rigthView != nil{
                _rigthView?.removeFromSuperview()
            }
            _rigthView = newValue
            if let _rigthView = _rigthView{
                self.addSubview(_rigthView)
                _rigthView.snp.remakeConstraints { make in
                    make.trailing.equalTo(containerView).offset(-16)
                    make.centerY.equalTo(containerView)
                    make.width.lessThanOrEqualTo(200)
                    make.height.equalTo(40.0)
                }
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    fileprivate func commonInit(){
        self.isUserInteractionEnabled = true
        self.containerView.isUserInteractionEnabled = true
        self.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.leading.bottom.trailing.equalTo(self)
            make.height.equalTo(App.navigationBarHeight)
        }
        
        if let leftView = leftView {
            containerView.addSubview(leftView)
            leftView.snp.makeConstraints { make in
                make.leading.equalTo(containerView).offset(16)
                make.centerY.equalTo(containerView)
                make.width.equalTo(40.0)
                make.height.equalTo(40.0)
            }
        }
        if let rightView = rightView {
            containerView.addSubview(rightView)
            rightView.snp.makeConstraints { make in
                make.trailing.equalTo(containerView).offset(-21)
                make.centerY.equalTo(containerView)
                make.width.equalTo(40.0)
                make.height.equalTo(40.0)
            }
        }
        if let centerView = centerView {
            containerView.addSubview(centerView)
            centerView.snp.makeConstraints { make in
                make.centerY.equalTo(containerView)
                make.leading.equalToSuperview().offset(40.0)
                make.trailing.equalToSuperview().offset(-40.0)
            }
        }
            containerView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(containerView)
            make.leading.equalToSuperview().offset(40.0)
            make.trailing.equalToSuperview().offset(-40.0)
        }
    }
}
