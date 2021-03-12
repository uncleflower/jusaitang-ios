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
        
        self.view.addSubview(competitoinNameLabel)
        self.view.addSubview(organizerLabel)
        self.view.addSubview(statusLabel)
        self.view.addSubview(contentLabel)
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
        
        deadlineView.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
            make.top.equalTo(contentLabel.snp.bottom).offset(40)
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
        } else {
            signUpButton.setTitle("创建队伍并报名", for: .normal)
        }
    }
    
    @objc func popView() {
        self.navigationController?.popViewController(animated: true)
    }
}
