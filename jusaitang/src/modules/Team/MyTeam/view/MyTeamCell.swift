//
//  MyTeamCell.swift
//  jusaitang
//
//  Created by Jiehao Zhang on 2021/4/24.
//

import UIKit

class MyTeamCell: UITableViewCell {
    
    let containerView: UIView = {
        let view = UIView()
        view.cornerRadius = 12
        view.backgroundColor = UIColor(hexString: "#FFFFFF")
        return view
    }()
    
    let teamLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.pf_medium(14)
        view.numberOfLines = 1
        view.text = "队伍：张三的队伍"
        view.textColor = UIColor(hexString: "#333333")
        return view
    }()
    
    let competitionLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.pf_medium(14)
        view.numberOfLines = 0
        view.text = "参加比赛：华迪杯"
        view.textColor = UIColor(hexString: "#333333")
        return view
    }()
    
    var peopelLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.pf_regular(14)
        view.text = "人员：限额3人，2人已报名"
        view.numberOfLines = 0
        view.textColor = UIColor(hexString: "#666666")
        return view
    }()
    
    var positionlLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.pf_regular(14)
        view.text = "身份：队员"
        view.numberOfLines = 0
        view.textColor = UIColor(hexString: "#666666")
        return view
    }()
    
    let adminButton: UIButton = {
        let view = UIButton()
        view.setTitle("管理队伍", for: .normal)
        view.setTitleColor(.white, for: .normal)
        view.backgroundColor = .default
        view.cornerRadius = 12
        view.titleLabel?.font = UIFont.pf_semibold(14)
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(containerView)
        
        containerView.addSubview(teamLabel)
        containerView.addSubview(competitionLabel)
        containerView.addSubview(peopelLabel)
        containerView.addSubview(positionlLabel)
        containerView.addSubview(adminButton)
        
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
        
        teamLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-50)
            make.height.equalTo(20)
        }
        
        competitionLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(16)
            make.top.equalTo(teamLabel.snp.bottom).offset(15)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(20)
        }
        
        peopelLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(16)
            make.top.equalTo(competitionLabel.snp.bottom).offset(15)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        positionlLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(16)
            make.top.equalTo(peopelLabel.snp.bottom).offset(15)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        adminButton.snp.makeConstraints { (make) in
            make.bottom.equalTo(containerView.snp.bottom).offset(-15)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(42)
        }
    }
    
    func reloadData(team: String, competition: String, peopel: String, position: String, showAdminButton: Bool) {
        self.teamLabel.text = team
        self.competitionLabel.text = competition
        self.peopelLabel.text = peopel
        self.positionlLabel.text = position
        self.adminButton.isHidden = !showAdminButton
    }
}
