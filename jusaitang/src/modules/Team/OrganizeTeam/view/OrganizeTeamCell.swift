//
//  OrganizeTeamCell.swift
//  jusaitang
//
//  Created by Jiehao Zhang on 2021/4/23.
//

import UIKit

class OrganizeTeamCell: UITableViewCell {
    
    var viewModel: OrganizeTeamCellVM!
    
    let containerView: UIView = {
        let view = UIView()
        view.cornerRadius = 12
        view.backgroundColor = UIColor(hexString: "#FFFFFF")
        return view
    }()
    
    let bkgView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexString: "#FFFFFF")
        return view
    }()
    
    let avatarImg: UIImageView = {
        let view = UIImageView()
        view.cornerRadius = 18
        view.image = UIImage(named: "avatar")
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    let nikenameLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.pf_medium(14)
        view.numberOfLines = 1
        view.text = "测试用户"
        view.textColor = UIColor(hexString: "#333333")
        return view
    }()
    
    let timeLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.pf_regular(12)
        view.numberOfLines = 1
        view.text = "28天前"
        view.textColor = UIColor(hexString: "#666666")
        return view
    }()
    
    let remainTimeLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.pf_regular(10)
        view.numberOfLines = 0
        view.text = "剩余3天"
        view.textColor = UIColor(hexString: "#666666")
        return view
    }()
    
    let titleLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.pf_medium(14)
        view.numberOfLines = 0
        view.text = "华迪杯"
        view.textColor = UIColor(hexString: "#333333")
        return view
    }()
    
    var textContetn: UILabel = {
        let view = UILabel()
        view.font = UIFont.pf_regular(14)
        view.text = "缺一名安卓开发者，有意向速度与我联系"
        view.numberOfLines = 0
        view.textColor = UIColor(hexString: "#666666")
        return view
    }()
    
    let enrollStatView: OrganizeTeamEnrollButton = {
        let view = OrganizeTeamEnrollButton()
        view.changeStatusToUnEnroll()
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(containerView)
        containerView.addSubview(bkgView)
        
        bkgView.addSubview(avatarImg)
        bkgView.addSubview(nikenameLabel)
        bkgView.addSubview(timeLabel)
        bkgView.addSubview(remainTimeLabel)
        
        containerView.addSubview(titleLabel)
        containerView.addSubview(textContetn)
        containerView.addSubview(enrollStatView)
        
        self.backgroundColor = UIColor(hexString: "#F7F7FB")
        
        makeBasecConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeBasecConstraints() {
        containerView.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
            make.top.equalToSuperview().offset(8)
            make.bottom.equalToSuperview().offset(-8)
        }
        
        bkgView.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
            make.top.equalToSuperview().offset(8)
            make.bottom.equalToSuperview().offset(-8)
        }
        
        avatarImg.snp.makeConstraints { (make) in
            make.leading.equalToSuperview()
            make.top.equalToSuperview().offset(5)
            make.height.equalTo(36)
            make.width.equalTo(36)
        }
        
        timeLabel.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview()
            make.top.equalToSuperview().offset(5)
            make.width.lessThanOrEqualTo(200)
            make.height.equalTo(17)
        }
        
        remainTimeLabel.snp.makeConstraints { (make) in
            make.trailing.equalTo(timeLabel.snp.trailing)
            make.top.equalTo(timeLabel.snp.bottom).offset(2)
            make.width.lessThanOrEqualTo(100)
            make.height.equalTo(14)
        }
        
        nikenameLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(avatarImg.snp.trailing).offset(15)
            make.top.equalTo(avatarImg.snp.top)
            make.trailing.equalToSuperview().offset(-50)
            make.height.equalTo(20)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(16)
            make.top.equalTo(remainTimeLabel.snp.bottom).offset(18)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(20)
        }
        
        textContetn.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(16)
            make.top.equalTo(titleLabel.snp.bottom).offset(18)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        enrollStatView.snp.makeConstraints { (make) in
            make.bottom.equalTo(bkgView.snp.bottom).offset(-15)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(42)
        }
        
    }
    
    func bindViewModel(viewModel: OrganizeTeamCellVM) {
        self.viewModel = viewModel
        let model = viewModel.model
        reloadData(
            teamID: model.id,
            nikename: model.captain.name,
            time: Date().updateTimeToCurrennTime(timeStamp: Double(model.createAt)!),
            remainTime: "剩余5天",
            title: model.competition.name,
            content: model.teamDescribe,
            maxCount: model.competition.peopelSum,
            curCount: model.teamHeadCount,
            isEnroll: model.applied
        )
    }
    
    func reloadData(
        teamID: String,
        nikename: String,
        time: String,
        remainTime: String,
        title: String,
        content: String,
        maxCount: Int,
        curCount: Int,
        isEnroll: Bool
    )
    {
        self.nikenameLabel.text = nikename
        self.timeLabel.text = time
        self.remainTimeLabel.text = remainTime
        self.titleLabel.text = title
        self.textContetn.text = content
        
        self.enrollStatView.reload(teamID: teamID, maxEnrollCount: maxCount, curEnrollCount: curCount, isFull: false, isEnroll: isEnroll, status: 1, enrollID: "123")
    }
}
