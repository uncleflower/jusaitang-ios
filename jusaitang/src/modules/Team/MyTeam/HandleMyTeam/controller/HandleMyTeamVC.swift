//
//  HandleMyTeamVC.swift
//  jusaitang
//
//  Created by Jiehao Zhang on 2021/4/24.
//

import UIKit
import MJRefresh
import RxSwift
import RxCocoa

class HandleMyTeamVC: BaseViewController {
    
    var viewModel: HandleMyTeamViewModel!
    
    private let disposBag = DisposeBag()
    
    let dismissButon: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "dismiss_arrow"), for: .normal)
        btn.contentMode = .center
        btn.imageView?.contentMode = .scaleAspectFit
        return btn
    }()
    
    let disbandTeamButton: UIButton = {
        let view = UIButton()
        view.setTitle("解散队伍", for: .normal)
        view.setTitleColor(.default, for: .normal)
        view.titleLabel?.font = UIFont.pf_semibold(14)
        return view
    }()
    
    let scrollView: BaseScrollView = {
        let view = BaseScrollView()
        view.backgroundColor = .clear
        view.alwaysBounceHorizontal = false
        view.alwaysBounceVertical = true
        view.bounces = true
        view.contentInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
        return view
    }()
    
    let containerView: UIView = {
        let view = UIView()
        return view
    }()
    
    let headerTitle: UILabel = {
        let view = UILabel()
        view.font = UIFont.pf_regular(12)
        view.text = "队伍信息"
        view.textColor = UIColor(hexString: "#666666")
        return view
    }()
    
    let headerView: HandleMyTeamHeaderView = {
        let view = HandleMyTeamHeaderView()
        return view
    }()
    
    let listTitle: UILabel = {
        let view = UILabel()
        view.font = UIFont.pf_regular(12)
        view.text = "队员信息"
        view.textColor = UIColor(hexString: "#666666")
        return view
    }()
    
    let reportCenterListView: HandleMyTeamListView = {
        let view = HandleMyTeamListView()
        return view
    }()
    
    let submitButton: UIButton = {
        let view = UIButton()
        view.backgroundColor = .default
        view.cornerRadius = 12
        view.setTitle("踢出队伍", for: .normal)
        view.setTitleColor(.white, for: .normal)
        view.titleLabel?.font = UIFont.pf_medium(16)
        return view
    }()
    
    init(teamID: String) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = HandleMyTeamViewModel(teamID: teamID)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubview(headerTitle)
        containerView.addSubview(headerView)
        containerView.addSubview(listTitle)
        containerView.addSubview(reportCenterListView)
        containerView.addSubview(submitButton)
    }
    
    override func makeConstraints() {
        super.makeConstraints()
        
        scrollView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        containerView.snp.makeConstraints { (make) in
            make.leading.trailing.equalTo(view)
            make.top.bottom.equalTo(scrollView)
        }
        
        headerTitle.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(15)
            make.top.equalToSuperview().offset(App.naviStatusHeight + 25)
            make.width.equalTo(50)
            make.height.equalTo(17)
        }
        
        headerView.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
            make.top.equalTo(headerTitle.snp.bottom).offset(8)
            make.height.equalTo(100)
        }
        
        listTitle.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(15)
            make.top.equalTo(headerView.snp.bottom).offset(32)
            make.width.equalTo(50)
            make.height.equalTo(17)
        }
        
        reportCenterListView.snp.makeConstraints { (make) in
            make.top.equalTo(listTitle.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
            make.height.equalTo(48)
        }
        
        submitButton.snp.makeConstraints { (make) in
            make.top.equalTo(reportCenterListView.snp.bottom).offset(50)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-30)
            make.height.equalTo(48)
            make.bottom.equalToSuperview().offset(-38-App.safeAreaBottom)
        }
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        
        self.headerView.bindViewModel(viewModel: self.viewModel)
        self.reportCenterListView.bindViewModel(viewModel: self.viewModel)
        
        self.viewModel.handleMyTeamListCellVMs.subscribe {[weak self] event in
            guard let vms = event.element else { return }
            if vms.count != 0 {
                self?.reportCenterListView.snp.updateConstraints { (make) in
                    make.height.equalTo(48 * vms.count)
                }
                self?.reportCenterListView.isHidden = false
            } else {
                self?.reportCenterListView.isHidden = true
            }
        }.disposed(by: disposBag)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationView.leftView = dismissButon
        self.navigationView.rightView = disbandTeamButton
        view.backgroundColor = UIColor(hexString: "#F7F7FB")
        
        disbandTeamButton.addTarget(self, action: #selector(disbandTeam), for: .touchUpInside)
        dismissButon.addTarget(self, action: #selector(popView), for: .touchUpInside)
        submitButton.addTarget(self, action: #selector(showKickOutAlert), for: .touchUpInside)
        
        viewModel.getTeamDetail { error in
            if let error = error {
                ErrorAlertView.show(error: error)
                return
            }
        }
    }
    
    @objc func disbandTeam() {
        let alert = AlertView(title: "确定吗", detail: "确定要解散“数学建模大赛”队伍吗？")
        let action1 = AlertAction(type: .none) {
            alert.dismiss()
        }
        action1.title = "取消"
        alert.addAction(alertAction: action1)
        
        let action2 = AlertAction(type: .none) {[weak self] in
            let req = TeamAPI.DeleteTeamReq()
            req.teamId = (self?.viewModel.teamID)!
            TeamAPI.deleteTeam(request: req) { _, error in
                if let error = error {
                    ErrorAlertView.show(error: error)
                    return
                }
                self?.popView()
            }
            alert.dismiss()
        }
        action2.title = "确定"
        alert.addAction(alertAction: action2)
        
        alert.show()
    }
    
    @objc func showKickOutAlert() {
        kickOut { [weak self] success in
            if !success {
                SlightAlert(title: "踢出队伍失败，请稍后重试").show()
            } else {
                SlightAlert(title: "踢出队伍成功").show()
                guard let oldVMs = try? self?.viewModel.handleMyTeamListCellVMs.value() else { return }
                var newVMs: [HandleMyTeamListCellVM] = oldVMs
                for userID in self!.viewModel.kickUserIDs {
                    for (index, vm) in oldVMs.enumerated() {
                        if vm.user.uid == userID {
                            newVMs.remove(at: index)
                        }
                    }
                }
                self?.viewModel.handleMyTeamListCellVMs.onNext(newVMs)
                self?.viewModel.kickUserIDs = []
            }
            self?.reportCenterListView.tableView.reloadData()
        }
    }
    
    @objc func kickOut(complete: @escaping(Bool) -> Void) {
        let group = DispatchGroup()
        var success: Bool = true
        for userID in viewModel.kickUserIDs {
            group.enter()
            viewModel.kickOut(userID: userID) { error in
                if let error = error {
                    success = false
                    ErrorAlertView.show(error: error)
                    return
                }
                group.leave()
            }
        }
        group.notify(queue: DispatchQueue.main) {
            if success {
                complete(true)
            } else {
                complete(false)
            }
        }
    }
    
    @objc func popView() {
        App.navigationController?.popViewController(animated: true)
    }
}
