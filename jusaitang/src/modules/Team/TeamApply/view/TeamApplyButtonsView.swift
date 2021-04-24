//
//  TeamApplyButtonsView.swift
//  jusaitang
//
//  Created by Jiehao Zhang on 2021/4/24.
//

import UIKit
import SnapKit

class TeamApplyButtonsView: UIView {
    
    enum ApplyStatus: Int {
        case unknown = -1
        case othersApply = 0
        case agreeOther = 1
        case refuseOther = 2
        case agreed = 3
        case refused = 4
        case underReview = 5
    }
        
    let agreeButton: UIButton = {
        let view = UIButton()
        view.setTitle("同意", for: .normal)
        view.setTitleColor(.white, for: .normal)
        view.cornerRadius = 10
        view.titleLabel?.font = UIFont.pf_semibold(14)
        view.backgroundColor = .default
        return view
    }()
    
    let refuseButton: UIButton = {
        let view = UIButton()
        view.setTitle("拒绝", for: .normal)
        view.titleLabel?.font = UIFont.pf_semibold(14)
        view.backgroundColor = .white
        view.cornerRadius = 10
        view.setTitleColor(UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1), for: .normal)
        view.borderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
        view.borderWidth = 1
        return view
    }()
    
    let oneButton: UIButton = {
        let view = UIButton()
        view.setTitleColor(.white, for: .normal)
        view.cornerRadius = 10
        view.titleLabel?.font = UIFont.pf_semibold(14)
        view.isUserInteractionEnabled = false
        return view
    }()
    
    let towButtonWidth = (App.screenWidth / 2) - 30 - 10
    let oneButtonWidth = App.screenWidth - 30
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(oneButton)
        self.addSubview(agreeButton)
        self.addSubview(refuseButton)
        
        makeConstraints()
        
        agreeButton.addTarget(self, action: #selector(agreeOther), for: .touchUpInside)
        refuseButton.addTarget(self, action: #selector(refuseOther), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeConstraints() {
        agreeButton.snp.makeConstraints { (make) in
            make.leading.top.bottom.equalToSuperview()
            make.width.equalTo(towButtonWidth)
        }
        
        refuseButton.snp.makeConstraints { (make) in
            make.trailing.top.bottom.equalToSuperview()
            make.width.equalTo(towButtonWidth)
        }
        
        oneButton.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    func reloadView(status: ApplyStatus) {
        switch status {
        case .othersApply:
            agreeButton.isHidden = false
            refuseButton.isHidden = false
            oneButton.isHidden = true
        case .agreeOther:
            agreeButton.isHidden = true
            refuseButton.isHidden = true
            oneButton.isHidden = false
            oneButton.setTitle("已同意", for: .normal)
            oneButton.setTitleColor(.white, for: .normal)
            oneButton.backgroundColor = .default
        case .refuseOther:
            agreeButton.isHidden = true
            refuseButton.isHidden = true
            oneButton.isHidden = false
            oneButton.setTitle("已拒绝", for: .normal)
            oneButton.setTitleColor(.white, for: .normal)
            oneButton.backgroundColor = .gray
        case .agreed:
            agreeButton.isHidden = true
            refuseButton.isHidden = true
            oneButton.isHidden = false
            oneButton.setTitle("已加入对方队伍", for: .normal)
            oneButton.setTitleColor(.white, for: .normal)
            oneButton.backgroundColor = .default
        case .refused:
            agreeButton.isHidden = true
            refuseButton.isHidden = true
            oneButton.isHidden = false
            oneButton.setTitle("已被对方拒绝", for: .normal)
            oneButton.setTitleColor(.white, for: .normal)
            oneButton.backgroundColor = .gray
        case .underReview:
            agreeButton.isHidden = true
            refuseButton.isHidden = true
            oneButton.isHidden = false
            oneButton.setTitle("审核中", for: .normal)
            oneButton.setTitleColor(.white, for: .normal)
            oneButton.backgroundColor = .default
        default:
            return
        }
    }
    
    @objc func agreeOther() {
        let alert = AlertView(title: "确定吗", detail: "您确定要同意该用户加入您的队伍吗？")
        let action1 = AlertAction(type: .none) {
            alert.dismiss()
        }
        action1.title = "取消"
        alert.addAction(alertAction: action1)
        
        let action2 = AlertAction(type: .none) {[weak self] in
            self?.agreeButton.isHidden = true
            self?.refuseButton.isHidden = true
            self?.oneButton.isHidden = false
            self?.oneButton.setTitle("已同意", for: .normal)
            self?.oneButton.setTitleColor(.white, for: .normal)
            self?.oneButton.backgroundColor = .default
            
            alert.dismiss()
        }
        action2.title = "确定"
        alert.addAction(alertAction: action2)
        
        alert.show()
    }
    
    @objc func refuseOther() {
        let alert = AlertView(title: "确定吗", detail: "您确定要拒绝该用户加入您的队伍吗？")
        let action1 = AlertAction(type: .none) {
            alert.dismiss()
        }
        action1.title = "取消"
        alert.addAction(alertAction: action1)
        
        let action2 = AlertAction(type: .none) {[weak self] in
            self?.agreeButton.isHidden = true
            self?.refuseButton.isHidden = true
            self?.oneButton.isHidden = false
            self?.oneButton.setTitle("已拒绝", for: .normal)
            self?.oneButton.setTitleColor(.white, for: .normal)
            self?.oneButton.backgroundColor = .gray
            
            alert.dismiss()
        }
        action2.title = "确定"
        alert.addAction(alertAction: action2)
        
        alert.show()
    }
}
