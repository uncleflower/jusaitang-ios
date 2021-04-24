//
//  OrganizeTeamEnrollButton.swift
//  jusaitang
//
//  Created by Jiehao Zhang on 2021/4/23.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class OrganizeTeamEnrollButton: UIView {
    
    enum Status: Int {
        case overdue = -1
        case open = 1
        case close = 2
    }
    
    var maxEnrollCount: Int = 0
    
    var curEnrollCount: Int = 0
    
    var isEnroll: Bool = true
    
    var isFull: Bool = false
    
    var status: Status = .open
    
    var enrollID: String = ""
    
    let containerView: UIView = {
        let view = UIControl()
        view.layer.cornerRadius = 12
        view.backgroundColor = UIColor(hexString: "#F7F7FB")
        return view
    }()
    
    let enrollButton: UIButton = {
        let view = UIButton()
        view.layer.maskedCorners = CACornerMask(rawValue: CACornerMask.layerMinXMaxYCorner.rawValue | CACornerMask.layerMaxXMinYCorner.rawValue | CACornerMask.layerMaxXMaxYCorner.rawValue)
        view.cornerRadius = 12
        view.backgroundColor = UIColor.default
        view.setTitle("立即报名", for: .normal)
        view.setTitleColor(UIColor(hexString: "#FFFFFF"), for: .normal)
        view.titleLabel?.font = UIFont.pf_medium(12)
        return view
    }()
    
    let monitorApplicantsLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.pf_regular(12)
        view.numberOfLines = 1
        view.textColor = UIColor(hexString: "#888888")
        return view
    }()

    let revokeButon: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "dynamic_revoke"), for: .normal)
        btn.contentMode = .scaleAspectFill
        btn.imageView?.contentMode = .scaleAspectFit
        btn.isHidden = true
        btn.isEnabled = false
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(containerView)
        containerView.addSubview(enrollButton)
        containerView.addSubview(monitorApplicantsLabel)
        containerView.addSubview(revokeButon)
        
        makeConstraints()
        
        enrollButton.addTarget(self, action: #selector(enroll), for: .touchUpInside)
        revokeButon.addTarget(self, action: #selector(revoke), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func reload(maxEnrollCount: Int, curEnrollCount: Int, isFull: Bool, isEnroll: Bool, status: Int, enrollID: String) {
        self.maxEnrollCount = maxEnrollCount
        self.curEnrollCount = curEnrollCount
        self.isEnroll = isEnroll
        self.isFull = isFull
        self.status = OrganizeTeamEnrollButton.Status(rawValue: status)!
        self.enrollID = enrollID
        
        monitorApplicantsLabel.text = "\(curEnrollCount)人已报名，限额\(maxEnrollCount)人"
        
        checkStatus()
    }
    
    func makeConstraints() {
        containerView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        enrollButton.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalTo(84)
        }
        
        monitorApplicantsLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(15)
            make.centerY.equalToSuperview()
            make.width.lessThanOrEqualTo(150)
            make.height.equalTo(17)
        }
        
        revokeButon.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview().offset(-15)
            make.centerY.equalToSuperview()
            make.width.equalTo(18)
            make.height.equalTo(18)
        }
    }
    
    func checkStatus() {
        if !isEnroll {
            changeStatusToUnEnroll()
        }
        
        if status == .overdue || isFull == true || status == .close {
            enrollButton.isEnabled = false
            enrollButton.backgroundColor = UIColor(hexString: "#E7E9ED")
            enrollButton.setTitle("无法报名", for: .disabled)
            enrollButton.titleLabel?.textColor = UIColor(hexString: "#8C97AF")
        }
        
        if isEnroll {
            changeStatusToEnrolled()
        }
    }
    
    func changeStatusToEnrolled() {
        enrollButton.snp.remakeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        enrollButton.setTitle("已报名，请与活动发起人保持联系", for: .disabled)
        enrollButton.backgroundColor = UIColor.default
        enrollButton.isEnabled = false
        if status != .overdue && status != .close {
            revokeButon.isHidden = false
            revokeButon.isEnabled = true
        }
        monitorApplicantsLabel.isHidden = true
        isEnroll = true
    }
    
    func changeStatusToUnEnroll() {
        enrollButton.snp.remakeConstraints { (make) in
            make.trailing.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalTo(84)
        }
        enrollButton.isEnabled = true
        monitorApplicantsLabel.text = "\(curEnrollCount)人已报名，限额\(maxEnrollCount)人"
        revokeButon.isHidden = true
        revokeButon.isEnabled = false
        monitorApplicantsLabel.isHidden = false
        isEnroll = false
    }
    
    @objc func enroll() {
        let alert = AlertView.init(title: "是否报名", subTitle: "是否确定报名，如果出现时间问题请自行与发布者协商哦")
        let action1 = AlertAction(type: .none) {
            alert.dismiss()
        }
        action1.title = "取消"
        let action2 = AlertAction(type: .none) { [weak self] in
            
            NotificationCenter.default.post(name: .reloadView, object: nil)
            self?.changeStatusToEnrolled()
            
            alert.dismiss()
        }
        action2.title = "确认报名"
        alert.addAction(alertAction: action1)
        alert.addAction(alertAction: action2)
        alert.show()
    }
    
    @objc func revoke() {
        let alert = AlertView.init(title: "是否取消报名", subTitle: "是否取消报名，取消后可再次进行报名提交，若超过时间限制则无法报名")
        let action1 = AlertAction(type: .none) {
            alert.dismiss()
        }
        action1.title = "返回"
        let action2 = AlertAction(type: .none) { [weak self] in
            NotificationCenter.default.post(name: .reloadView, object: nil)
            self?.curEnrollCount = 2
            
            self?.changeStatusToUnEnroll()
            
            alert.dismiss()
        }
        action2.title = "确认取消"
        alert.addAction(alertAction: action1)
        alert.addAction(alertAction: action2)
        alert.show()
    }
}
