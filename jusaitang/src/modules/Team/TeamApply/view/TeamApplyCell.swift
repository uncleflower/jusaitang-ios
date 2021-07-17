//
//  TeamApplyCell.swift
//  jusaitang
//
//  Created by Jiehao Zhang on 2021/4/24.
//

import UIKit

class TeamApplyCell: UITableViewCell {
    
    var viewModel: TeamApplyCellViewModel!
    
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
        view.text = "8天前"
        view.textColor = UIColor(hexString: "#666666")
        return view
    }()
    
    var textContetn: UILabel = {
        let view = UILabel()
        view.font = UIFont.pf_regular(14)
        view.text = "申请加入你的“华迪杯赛”队伍"
        view.numberOfLines = 0
        view.textColor = UIColor(hexString: "#666666")
        return view
    }()
    
    let applyButton: TeamApplyButtonsView = {
        let view = TeamApplyButtonsView()
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(containerView)
        containerView.addSubview(bkgView)
        
        bkgView.addSubview(avatarImg)
        bkgView.addSubview(nikenameLabel)
        bkgView.addSubview(timeLabel)
        containerView.addSubview(textContetn)
        containerView.addSubview(applyButton)
        
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
        
        nikenameLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(avatarImg.snp.trailing).offset(15)
            make.top.equalTo(avatarImg.snp.top)
            make.trailing.equalToSuperview().offset(-50)
            make.height.equalTo(20)
        }
        
        textContetn.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(16)
            make.top.equalTo(avatarImg.snp.bottom).offset(18)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        applyButton.snp.makeConstraints { (make) in
            make.bottom.equalTo(bkgView.snp.bottom).offset(-15)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(42)
        }
        
    }
    
    func bindViewModel(viewModel: TeamApplyCellViewModel) {
        self.viewModel = viewModel
        let model = viewModel.model
        reloadData(
            nikename: model.user.name,
            time: Date().updateTimeToCurrennTime(timeStamp: Double(model.creatAt)),
            textContent: model.applyContent,
            status: TeamApplyButtonsView.ApplyStatus(rawValue: model.applyState) ?? .unknown
        )
    }
    
    func reloadData(nikename: String, time: String, textContent: String, status: TeamApplyButtonsView.ApplyStatus) {
        self.nikenameLabel.text = nikename
        self.timeLabel.text = time
        self.textContetn.text = textContent
        
        self.applyButton.reloadView(status: status)
    }
}
