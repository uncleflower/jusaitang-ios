//
//  AnnouncementTableView.swift
//  jusaitang
//
//  Created by Jiehao Zhang on 2021/3/10.
//

import UIKit
import RxSwift
import RxCocoa
import MJRefresh

class AnnouncementTableView: UITableViewCell {
    
    var viewModel: AnnouncementTableVM = AnnouncementTableVM()
    
    let titleLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.pf_semibold(14)
        view.numberOfLines = 0
        view.textColor = UIColor(hexString: "#333333")
        return view
    }()

    let moreButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(named: "more_announcement"), for: .normal)
        view.contentMode = .center
        view.imageView?.contentMode = .scaleAspectFit
        return view
    }()
    
    var tableView: UITableView!
    
    let containerView: UIView = {
        let view = UIView()
        view.cornerRadius = 12
        view.backgroundColor = .white
        return view
    }()
        
    private let disposeBag = DisposeBag()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = UIColor.backgroundColor
        
        tableView = BaseTableView.init(frame: self.frame,style: .plain)
        tableView.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.contentInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
        tableView.separatorStyle = .none
        tableView.allowsSelection = true
        tableView.isScrollEnabled = false
        tableView.register(AnnouncementTableViewCell.self, forCellReuseIdentifier: "AnnouncementTableViewCell")
        
        contentView.addSubview(containerView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(moreButton)
        containerView.addSubview(tableView)
        
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeConstraints() {
        containerView.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
            make.top.equalToSuperview()
            make.bottom.equalToSuperview().offset(-18)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(15)
            make.top.equalToSuperview().offset(18)
            make.height.equalTo(17)
            make.width.lessThanOrEqualTo(80)
        }
        
        moreButton.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview().offset(-12)
            make.top.equalToSuperview().offset(13)
            make.height.equalTo(28)
            make.width.equalTo(58)
        }
        
        tableView.snp.makeConstraints { (make) in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.bottom.equalToSuperview().offset(-10)
        }
    }
    
    func bindViewModel(viewModel: AnnouncementTableVM) {
        self.viewModel = viewModel
        
        viewModel.titleObservable.subscribe(onNext: {[weak self] (title) in
            self?.titleLabel.text = title
        }).disposed(by: disposeBag)
        
        viewModel.announcementCellVMs.subscribe {[weak self] (vms) in
            self?.tableView.reloadData()
        }.disposed(by: disposeBag)
        
        self.moreButton.addTarget(self, action: #selector(seeList), for: .touchUpInside)
    }
    
    @objc func seeList() {
        var type: AnnouncementType = .unknown
        if self.titleLabel.text == "获奖公告" {
            type = .competition
        } else if self.titleLabel.text == "系统公告" {
            type = .system
        }
        
        let vc = AnnouncementListVC(type: type)
        App.navigationController?.pushViewController(vc, animated: true)
    }
    
    func showSystemAnnouncementDetail(id: String) {
        viewModel.getSysAnnouncementDetail(id: id) { (model, error) in
            if let error = error {
                ErrorAlertView.show(error: error, style: .topError)
                return
            }
            guard let model = model else {return}
            let alert = AlertView(title: model.title, subDetail: model.content)
            let action = AlertAction(type: .none) {
                alert.dismiss()
            }
            action.title = "知道了"
            alert.addAction(alertAction: action)
            alert.show()
        }
    }
    
    func showCompetitionAnnouncementDetail(id: String) {
        viewModel.getCompAnnouncementDetail(id: id) { (model, error) in
            if let error = error {
                ErrorAlertView.show(error: error, style: .topError)
                return
            }
            guard let model = model else {return}
            let alert = AlertView(title: model.fileName, subTitle: "确定要下载该文件吗")
            let action1 = AlertAction(type: .none) {
                alert.dismiss()
            }
            action1.title = "取消"
            alert.addAction(alertAction: action1)
            let action2 = AlertAction(type: .none) {
                Router.openWebView(url: model.fileURL)
                alert.dismiss()
            }
            action2.title = "确定"
            alert.addAction(alertAction: action2)
            alert.show()
        }
    }
    
}

extension AnnouncementTableView: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        if let count = try? viewModel.announcementCellVMs.value().count {
            if count != 0 {
                return 1
            }
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 37
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let id = try? viewModel.announcementCellVMs.value()[indexPath.item].model.id else {return}
        
        if self.titleLabel.text == "获奖公告" {
            showCompetitionAnnouncementDetail(id: id)
        } else if self.titleLabel.text == "系统公告" {
            showSystemAnnouncementDetail(id: id)
        }
    }
}

extension AnnouncementTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = try? viewModel.announcementCellVMs.value().count {
            return count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AnnouncementTableViewCell", for: indexPath) as! AnnouncementTableViewCell
        if let vm = try? viewModel.announcementCellVMs.value()[indexPath.item] {
            cell.bindViewModel(viewModel: vm)
        }
        cell.selectionStyle = .none
        return cell
    }
}

