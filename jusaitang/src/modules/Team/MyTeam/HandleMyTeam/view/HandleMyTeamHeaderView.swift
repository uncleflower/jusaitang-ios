//
//  HandleMyTeamHeaderView.swift
//  jusaitang
//
//  Created by Jiehao Zhang on 2021/4/24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class HandleMyTeamHeaderView: UIView {
    
    let containerView: UIView = {
        let view = UIView()
        view.cornerRadius = 12
        view.backgroundColor = .white
        return view
    }()
    
    let avatarImg: UIImageView = {
        let view = UIImageView()
        view.cornerRadius = 12
        view.contentMode = .scaleAspectFill
        view.isUserInteractionEnabled = false
        view.clipsToBounds = true
        view.image = UIImage(named: "avatar")
        return view
    }()
    
    let nikenameLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.pf_medium(14)
        view.numberOfLines = 1
        view.textColor = UIColor(hexString: "#333333")
        view.text = "小明的队伍"
        return view
    }()
    
    let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexString: "#EAEAEA")
        return view
    }()
    
    let contentLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.pf_regular(12)
        view.numberOfLines = 0
        view.text = "参加比赛：天梯赛"
        view.textColor = UIColor(hexString: "#333333")
        return view
    }()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(containerView)
        containerView.addSubview(avatarImg)
        containerView.addSubview(nikenameLabel)
        containerView.addSubview(lineView)
        containerView.addSubview(contentLabel)
        
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeConstraints() {
        containerView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        avatarImg.snp.makeConstraints { (make) in
            make.leading.top.equalToSuperview().offset(15)
            make.height.width.equalTo(24)
        }
        
        nikenameLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(avatarImg)
            make.height.equalTo(20)
            make.leading.equalTo(avatarImg.snp.trailing).offset(18)
            make.trailing.equalToSuperview().offset(-15)
        }
        
        lineView.snp.makeConstraints { (make) in
            make.top.equalTo(avatarImg.snp.bottom).offset(16)
            make.height.equalTo(1)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
        }
        
        contentLabel.snp.makeConstraints { (make) in
            make.top.equalTo(lineView.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
            make.bottom.equalToSuperview().offset(-15)
        }
    }
}
