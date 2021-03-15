//
//  CompetitoinDetailVC.swift
//  jusaitang
//
//  Created by Jiehao Zhang on 2021/3/10.
//

import UIKit
import RxSwift
import RxCocoa

class CompetitionDetailVC: BaseViewController {
    
    private let disposeBag = DisposeBag()
    
    var viewModel: CompetitionDetailVM!
    
    let dismissButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "dismiss_arrow"), for: .normal)
        btn.contentMode = .center
        btn.imageView?.contentMode = .scaleAspectFit
        return btn
    }()
    
//    let scrollView: BaseScrollView = {
//        let view = BaseScrollView()
//        view.backgroundColor = .clear
//        view.alwaysBounceHorizontal = false
//        view.alwaysBounceVertical = true
//        view.canCancelContentTouches = true
//        view.bounces = true
//        view.contentInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
//        return view
//    }()
//
//    let containerView: UIView = {
//        let view = UIView()
//        view.isUserInteractionEnabled = true
//        return view
//    }()
    
    let competitoinNameLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.pf_medium(20)
        view.textColor = UIColor(hexString: "#333333")
        return view
    }()
    
    let organizerLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.pf_medium(14)
        view.textColor = UIColor(hexString: "#333333")
        return view
    }()
    
    let statusLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.pf_medium(14)
        view.textColor = UIColor(hexString: "#333333")
        return view
    }()
    
    let contentLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.pf_medium(12)
        view.numberOfLines = 0
        view.textColor = UIColor(hexString: "#666666")
        return view
    }()
    
    let competitionImageView: UIImageView = {
        let view = UIImageView()
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFill
        view.cornerRadius = 5
        return view
    }()
    
    let deadlineView: IconLabelView = {
        let view = IconLabelView()
        view.icon.image = UIImage(named: "competitionDetail_deadline")
        return view
    }()
    
    let locationView: IconLabelView = {
        let view = IconLabelView()
        view.icon.image = UIImage(named: "competitionDetail_location")
        return view
    }()
    
    let maxPeopleView: IconLabelView = {
        let view = IconLabelView()
        view.icon.image = UIImage(named: "competitionDetail_people")
        return view
    }()
    
    let contactPeopleView: IconLabelView = {
        let view = IconLabelView()
        view.icon.image = UIImage(named: "competitionDetail_connect_people")
        return view
    }()
    
    let contactInfomationView: IconLabelView = {
        let view = IconLabelView()
        view.icon.image = UIImage(named: "competitionDetail_connect")
        view.titleLabel.textColor = .systemBlue
        return view
    }()
    
    let officialWebsiteView: IconLabelView = {
        let view = IconLabelView()
        view.titleLabel.textColor = UIColor.systemBlue
        view.titleLabel.text = "竞赛官网"
        view.icon.image = UIImage(named: "competitionDetail_website")
        return view
    }()
    
    let signUpButton: UIButton = {
        let view = UIButton()
        view.backgroundColor = .default
        view.cornerRadius = 10
        view.setTitleColor(.white, for: .normal)
        view.titleLabel?.font = UIFont.pf_semibold(16)
        return view
    }()
    
    init(competitoinID: String) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = CompetitionDetailVM(id: competitoinID)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        
//        self.view.addSubview(scrollView)
//        self.scrollView.addSubview(containerView)
//        self.containerView.addSubview(competitoinNameLabel)
//        self.containerView.addSubview(organizerLabel)
//        self.containerView.addSubview(statusLabel)
//        self.containerView.addSubview(contentLabel)
//        self.containerView.addSubview(competitionImageView)
//        self.containerView.addSubview(deadlineView)
//        self.containerView.addSubview(locationView)
//        self.containerView.addSubview(maxPeopleView)
//        self.containerView.addSubview(contactPeopleView)
//        self.containerView.addSubview(contactInfomationView)
//        self.containerView.addSubview(officialWebsiteView)
//        self.containerView.addSubview(signUpButton)
        self.view.addSubview(competitoinNameLabel)
        self.view.addSubview(organizerLabel)
        self.view.addSubview(statusLabel)
        self.view.addSubview(contentLabel)
        self.view.addSubview(competitionImageView)
        self.view.addSubview(deadlineView)
        self.view.addSubview(locationView)
        self.view.addSubview(maxPeopleView)
        self.view.addSubview(contactPeopleView)
        self.view.addSubview(contactInfomationView)
        self.view.addSubview(officialWebsiteView)
        self.view.addSubview(signUpButton)
    }
    
    override func makeConstraints() {
        super.makeConstraints()
        
//        scrollView.snp.makeConstraints { (make) in
//            make.top.equalToSuperview()
//            make.leading.equalToSuperview()
//            make.trailing.equalToSuperview()
//            make.bottom.equalToSuperview()
//        }
//
//        containerView.snp.makeConstraints { (make) in
//            make.leading.trailing.equalTo(view)
//            make.top.bottom.equalTo(scrollView)
//        }
        
        competitoinNameLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
            make.top.equalToSuperview().offset(App.naviStatusHeight + 20)
            make.height.equalTo(20)
        }
        
        organizerLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(15)
            make.top.equalTo(competitoinNameLabel.snp.bottom).offset(20)
            make.height.equalTo(15)
            make.width.lessThanOrEqualTo(200)
        }
        
        statusLabel.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview().offset(-15)
            make.centerY.equalTo(organizerLabel)
            make.height.equalTo(15)
            make.width.lessThanOrEqualTo(200)
        }
        
        contentLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
            make.top.equalTo(organizerLabel.snp.bottom).offset(20)
        }
        
        competitionImageView.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
            make.top.equalTo(contentLabel.snp.bottom).offset(10)
            make.height.equalTo(180)
        }
        
        deadlineView.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
            make.top.equalTo(competitionImageView.snp.bottom).offset(40)
            make.height.equalTo(16)
        }
        
        locationView.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
            make.top.equalTo(deadlineView.snp.bottom).offset(20)
            make.height.equalTo(16)
        }
        
        maxPeopleView.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
            make.top.equalTo(locationView.snp.bottom).offset(20)
            make.height.equalTo(16)
        }
        
        contactPeopleView.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
            make.top.equalTo(maxPeopleView.snp.bottom).offset(20)
            make.height.equalTo(16)
        }
        
        contactInfomationView.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
            make.top.equalTo(contactPeopleView.snp.bottom).offset(20)
            make.height.equalTo(16)
        }
        
        officialWebsiteView.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(15)
            make.width.lessThanOrEqualTo(150)
            make.top.equalTo(contactInfomationView.snp.bottom).offset(20)
            make.height.equalTo(16)
        }
        
        signUpButton.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
            make.top.equalTo(officialWebsiteView.snp.bottom).offset(45)
            make.height.equalTo(50)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationView.backgroundColor = .white
        self.navigationView.leftView = dismissButton
        self.navigationView.titleLabel.text = "比赛详情"
        
        dismissButton.addTarget(self, action: #selector(popView), for: .touchUpInside)
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        
        viewModel.getCompetitionDetail {[weak self] (error) in
            if let error = error {
                ErrorAlertView.show(error: error, style: .topError)
                return
            }
            
            self?.loadData()
        }
    }
    
    func loadData() {
        guard let model = viewModel.model else {return}
        competitoinNameLabel.text = model.name
        organizerLabel.text = model.organizer
        if model.status == .goingon {
            statusLabel.text = "进行中"
        } else if model.status == .end {
            statusLabel.text = "已结束"
        }
        contentLabel.text = model.content
        competitionImageView.setImage(url: imageHost + model.imageURL)
        let date = Date(timeIntervalSince1970: TimeInterval(model.deadline)!)
        deadlineView.titleLabel.text = "截止时间: \(date.toString(dateFormat: "yyyy-MM-dd"))"
        locationView.titleLabel.text = "竞赛地点: \(model.address)"
        maxPeopleView.titleLabel.text = "参赛人数: \(model.peopelSum)"
        contactPeopleView.titleLabel.text = "联系人: \(model.contactPeople)"
        contactInfomationView.titleLabel.text = "联系方式: \(model.contactInformation)"
        contactInfomationView.removeAction()
        contactInfomationView.addAction {
            UIPasteboard.general.string = model.contactInformation
            SlightAlert(title: "已复制联系方式").show()
        }
        officialWebsiteView.removeAction()
        if model.officialWebsite != "" {
            officialWebsiteView.addAction {
                Router.openWebView(url: model.officialWebsite)
            }
        } else {
            officialWebsiteView.addAction {
                SlightAlert(title: "该竞赛暂无官网").show()
            }
        }
        if model.peopelSum == 1 {
            signUpButton.setTitle("立即报名", for: .normal)
            signUpButton.addTarget(self, action: #selector(singleDoApply), for: .touchUpInside)
        } else {
            signUpButton.setTitle("创建队伍并报名", for: .normal)
            signUpButton.addTarget(self, action: #selector(groupDoApply), for: .touchUpInside)
        }
        
        
    }
    
    @objc func popView() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func singleDoApply() {
        let alert = AlertView(title: "报名", subTitle: "确定要报名\(viewModel.model.name)吗？")
        let action1 = AlertAction(type: .none) {
            alert.dismiss()
        }
        action1.title = "取消"
        alert.addAction(alertAction: action1)
        let action2 = AlertAction(type: .none) {[weak self] in
            self?.viewModel.singleDoApply { (error) in
                if let error = error {
                    ErrorAlertView.show(error: error, style: .topError)
                    return
                }
                
                SlightAlert(title: "报名成功", image: "slight_alert_tick").show()
                self?.popView()
            }
            alert.dismiss()
        }
        action2.title = "确定"
        alert.addAction(alertAction: action2)
        alert.show()
    }
    
    @objc func groupDoApply() {
        SlightAlert(title: "正在开发中").show()
    }
}
