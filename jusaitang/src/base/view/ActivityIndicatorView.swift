//
//  ActivityIndicatorView.swift
//  an-xin-bang
//
//  Created by Duona Zhou on 7/8/20.
//  Copyright © 2020 IdeThink Inc. All rights reserved.
//

import UIKit

enum ActivityIndicatorViewStyle {
    case fullScreen
}

class ActivityIndicatorView: UIView {
    
    let style:ActivityIndicatorViewStyle
    
    static func show(title:String, style:ActivityIndicatorViewStyle = .fullScreen) -> ActivityIndicatorView?{
        guard let window = UIApplication.shared.windows.first else {return nil}
        let indicatorView = FullScreenActivityIndicatorView.init(
            frame:  CGRect(x: 0, y: 0, width: App.screenWidth, height: App.screenHeight),
            style: .fullScreen
        )
        indicatorView.load(title: title)
        window.addSubview(indicatorView)
        indicatorView.startAnimation()
        return indicatorView
    }
    
    init(frame: CGRect, style: ActivityIndicatorViewStyle) {
        self.style = style
        super.init(frame: frame)
        setup()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(){
    }
    
    func makeConstraints(){
    }
    
    func prepare(){
    }
    
    func show(){
        self.prepare()
        self.startAnimation()
    }
    
    func startAnimation(){
    }
    
    
    func endAnimation(){
    }
    
    @objc func dismiss(){
    }
}



class FullScreenActivityIndicatorView:ActivityIndicatorView{
    
    let containarView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexString: "#3F4041",alpha: 0.79)
        view.layer.cornerRadius = 8
        return view
    }()
    
    let indicatorView: UIActivityIndicatorView = {
        let indicatorView = UIActivityIndicatorView()
        indicatorView.transform = .init(scaleX: 1.5, y: 1.5)
        return indicatorView
    }()
    
    let titleView: UILabel = {
        let titleView = UILabel()
        return titleView
    }()
    
    func load(title:String){
        titleView.text = title
    }
    
    override func setup(){
        super.setup()
        self.backgroundColor = UIColor(hexString: "#666666", alpha: 0.79)
        addSubview(containarView)
        containarView.addSubview(indicatorView)
        containarView.addSubview(titleView)
    }
    
    override func makeConstraints(){
        super.makeConstraints()
        indicatorView.snp.makeConstraints { (view) in
            view.top.equalTo(18)
            view.height.equalTo(32)
            view.width.equalTo(32)
            view.centerX.equalToSuperview()
        }
        
        titleView.snp.makeConstraints { (view) in
            view.top.equalTo(self.indicatorView.snp.bottom).offset(12)
            view.centerX.equalToSuperview()
            view.width.lessThanOrEqualTo(200)
            view.height.lessThanOrEqualTo(200)
        }
        
        containarView.snp.makeConstraints { (view) in
            view.centerX.equalToSuperview()
            view.centerY.equalToSuperview()
            view.width.equalTo(self.titleView).offset(32)
            view.bottom.equalTo(self.titleView).offset(9)
        }
    }
    
    override func prepare(){
        super.prepare()
        self.alpha = 0
    }
    
    override func startAnimation(){
        indicatorView.startAnimating()
        let animations: (() -> Void) = {
            self.alpha = 1
        }
        
        UIView.animate(withDuration: 0.35, animations: animations, completion: nil)
    }
    
    @objc override func dismiss(){
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
