//
//  MsgPushedView.swift
//  an-xin-bang
//
//  Created by Jiehao Zhang on 2020/8/1.
//  Copyright © 2020 IdeThink Inc. All rights reserved.
//

import UIKit
import SnapKit

class MsgPushedView: UIView {
    
    var timer: Timer?
    var second = 2
    
    let containerView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: App.screenWidth, height: 150))
        view.cornerRadius = 15
        view.backgroundColor = .white
        view.clipsToBounds = false
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.33
        view.layer.shadowRadius = 15
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowPath = UIBezierPath(rect: view.bounds).cgPath
        return view
    }()
    
    let nameLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.pf_regular(13)
        view.numberOfLines = 0
        view.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        return view
    }()
    
    let timeLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.pf_regular(13)
        view.text = "现在"
        view.textAlignment = .right
        view.numberOfLines = 0
        view.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        return view
    }()
    
    let contentLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.pf_regular(15)
        view.numberOfLines = 2
        view.textColor = UIColor(red: 0.19, green: 0.19, blue: 0.19, alpha: 1)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(containerView)
        containerView.addSubview(nameLabel)
        containerView.addSubview(timeLabel)
        containerView.addSubview(contentLabel)
                
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeConstraints() {
        
        nameLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(43)
            make.leading.equalToSuperview().offset(20)
            make.width.equalTo(200)
            make.height.equalTo(22)
        }
        
        timeLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(43)
            make.trailing.equalToSuperview().offset(-20)
            make.width.equalTo(35)
            make.height.equalTo(18)
        }
        
        contentLabel.snp.makeConstraints { (make) in
            make.top.equalTo(nameLabel.snp.bottom).offset(3)
            make.leading.equalToSuperview().offset(20)
            make.width.equalTo(App.screenWidth - 40)
            make.trailing.equalToSuperview().offset(-20)
            make.height.lessThanOrEqualTo(45)
            make.bottom.equalToSuperview().offset(-16)
        }
    }
    
//    func setUpContaint(singlMsg: SingleMessgae) {
//
//        if let sender = singlMsg.target as? SingleMessgae.TargetUser.Guard {
//            nameLabel.text = "\(sender.name)："
//        }
//        if let content = singlMsg.content as? MessageContent.Text {
//            contentLabel.text = content.text
//        }
//    }
    
    func prepare() {
        containerView.frame.origin.y = -containerView.height
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(hideView), userInfo: nil, repeats: true)
        timer!.fire()
    }
    
//    func show(singleMsg: SingleMessgae) {
//        prepare()
//
//        setUpContaint(singlMsg: singleMsg)
//
//        guard let window = UIApplication.shared.windows.first else {return}
//
//        window.addSubview(self)
//
//        UIView.animate(withDuration: 0.5) {
//            self.containerView.frame.origin.y = 0
//            self.containerView.snp.updateConstraints { (make) in
//                make.top.equalToSuperview()
//            }
//        }
//    }
    
    @objc func hideView() {
        if second > 0 {
            second -= 1
            return
        }
        
        UIView.animate(withDuration: 0.35, animations: {
            self.containerView.frame.origin.y = -self.containerView.height
        }) { (_) in
            self.removeFromSuperview()
            self.timer!.invalidate()
            self.timer = nil
        }
    }
}
