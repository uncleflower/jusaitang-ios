//
//  AnnouncementListVC.swift
//  jusaitang
//
//  Created by Jiehao Zhang on 2021/3/10.
//

import UIKit
import RxSwift
import RxCocoa
import MJRefresh

enum AnnouncementType: Int {
    case unknown = -1
    case competition = 0
    case system = 1
}

class AnnouncementListVC: BaseViewController {
    
    private let disposeBag = DisposeBag()
    
    let viewModel: AnnouncementListVM = .init()
    
    var type: AnnouncementType = .unknown
    
    let dismissButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "dismiss_arrow"), for: .normal)
        btn.contentMode = .center
        btn.imageView?.contentMode = .scaleAspectFit
        return btn
    }()
    
    var tableView: UITableView!
    
    init(type: AnnouncementType) {
        super.init(nibName: nil, bundle: nil)
        self.type = type
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        
        tableView = BaseTableView.init(frame: self.view.frame,style: .plain)
        tableView.backgroundColor = UIColor(hexString: "#F7F7FB")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.contentInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
        tableView.separatorStyle = .none
        tableView.allowsSelection = true
        tableView.isScrollEnabled = false
        tableView.register(AnnouncementTableViewCell.self, forCellReuseIdentifier: "AnnouncementTableViewCell")
        
        self.view.addSubview(tableView)
    }
    
    override func makeConstraints() {
        super.makeConstraints()
        
        tableView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(App.naviStatusHeight)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if type == .competition {
            self.navigationView.titleLabel.text = "获奖通知"
        } else {
            self.navigationView.titleLabel.text = "系统公告"
        }
        
        self.tableView.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(headerRefresh))
        let footer = MJRefreshAutoNormalFooter(refreshingTarget: self, refreshingAction: #selector(footerRefresh))
        footer.setTitle("没有更多数据", for: .noMoreData)
        footer.stateLabel?.textColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
        footer.stateLabel?.font = UIFont.pf_medium(11)
        self.tableView.mj_footer = footer
        self.navigationView.leftView = dismissButton
        dismissButton.addTarget(self, action: #selector(popView), for: .touchUpInside)
        
        headerRefresh()
    }
    
    override func bindViewModel() {
        self.viewModel.announcementCellVMs.subscribe(onNext: {[weak self] vms in
            self?.tableView.reloadData()
        }).disposed(by: disposeBag)
    }
    
    @objc func popView() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func setFooterTitle() {
        if tableView.contentSize.height > tableView.frame.size.height {
            (tableView.mj_footer as? MJRefreshAutoNormalFooter)?.setTitle("没有更多数据", for: .noMoreData)
        } else {
            (tableView.mj_footer as? MJRefreshAutoNormalFooter)?.setTitle(" ", for: .noMoreData)
        }
    }
    
    @objc func headerRefresh() {
        if type == .competition {
            self.viewModel.getCompAnnouncementList {[weak self] (isLast, error) in
                if let error = error {
                    ErrorAlertView.show(error: error, style: .topError)
                    return
                }
                
                self?.tableView.mj_header?.endRefreshing()
                if isLast {
                    self?.setFooterTitle()
                    self?.tableView.mj_footer?.endRefreshingWithNoMoreData()
                }
            }
        } else if type == .system {
            self.viewModel.getSysAnnouncementList {[weak self] (isLast, error) in
                if let error = error {
                    ErrorAlertView.show(error: error, style: .topError)
                    return
                }
                
                self?.tableView.mj_header?.endRefreshing()
                if isLast {
                    self?.setFooterTitle()
                    self?.tableView.mj_footer?.endRefreshingWithNoMoreData()
                }
            }
        }
    }
    
    @objc func footerRefresh() {
        if type == .competition {
            self.viewModel.getMoreCompAnnouncementList {[weak self] (isLast, error) in
                if let error = error {
                    ErrorAlertView.show(error: error, style: .topError)
                    return
                }
                if !isLast {
                    self?.tableView.mj_footer?.endRefreshing()
                    return
                }
                self?.setFooterTitle()
                self?.tableView.mj_footer?.endRefreshingWithNoMoreData()
            }
        } else if type == .system {
            self.viewModel.getMoreSysAnnouncementList {[weak self] (isLast, error) in
                if let error = error {
                    ErrorAlertView.show(error: error, style: .topError)
                    return
                }
                if !isLast {
                    self?.tableView.mj_footer?.endRefreshing()
                    return
                }
                self?.setFooterTitle()
                self?.tableView.mj_footer?.endRefreshingWithNoMoreData()
            }
        }
    }
}

extension AnnouncementListVC: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        if let count = try? viewModel.announcementCellVMs.value().count {
            if count != 0 {
                return 1
            }
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

extension AnnouncementListVC: UITableViewDataSource {
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
