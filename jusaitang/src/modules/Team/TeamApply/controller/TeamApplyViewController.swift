//
//  TeamApplyViewController.swift
//  jusaitang
//
//  Created by Jiehao Zhang on 2021/3/5.
//

import UIKit
import RxSwift
import RxCocoa
import MJRefresh
import JXSegmentedView

class TeamApplyViewController: BaseViewController {
    
    var tableView: UITableView!
    
    private let disposeBag = DisposeBag()
    
    var listViewDidScrollCallback: ((UIScrollView) -> ())?
    
    var cell: TeamApplyCell?
    
    override func loadView() {
        super.loadView() 
        tableView = BaseTableView.init(frame: self.view.frame,style: .plain)
        tableView.backgroundColor = UIColor.backgroundColor
        tableView.delegate = self
        tableView.dataSource = self
        tableView.contentInset = UIEdgeInsets.init(top: 0, left: 0, bottom: App.tabBarHeight * 3 + App.safeAreaBottom + 10, right: 0)
        tableView.separatorStyle = .none
        tableView.register(TeamApplyCell.self, forCellReuseIdentifier: "TeamApplyCell")
        view.addSubview(tableView)
    }
    
    override func makeConstraints() {
        super.makeConstraints()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(headerRefresh))
        self.navigationView.removeFromSuperview()
    }
    
    @objc func headerRefresh() {
        cell!.reloadData(nikename: "张杰豪", time: "1天前", textContent: "申请加入“数学建模大赛”队伍", status: .agreed)
        (tableView.mj_header as? MJRefreshNormalHeader)?.endRefreshing()
    }
    
}

extension TeamApplyViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}

extension TeamApplyViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        cell = tableView.dequeueReusableCell(withIdentifier: "TeamApplyCell", for: indexPath) as? TeamApplyCell
        
        if indexPath.row == 0 {
            cell!.reloadData(nikename: "龚燃", time: "1天前", textContent: "申请加入你的“数学建模竞赛”队伍", status: .othersApply)
        } else if indexPath.row == 1 {
            cell!.reloadData(nikename: "于杰丞", time: "2天前", textContent: "申请加入你的“数学建模竞赛”队伍", status: .othersApply)
        } else if indexPath.row == 2 {
            cell!.reloadData(nikename: "龚燃", time: "3天前", textContent: "申请加入“天梯赛”队伍", status: .agreed)
        } else if indexPath.row == 3 {
            cell!.reloadData(nikename: "李四", time: "5天前", textContent: "申请加入“互联网+竞赛”队伍", status: .refused)
        } else if indexPath.row == 4 {
            cell!.reloadData(nikename: "王五", time: "10天前", textContent: "申请加入“数学建模竞赛”队伍", status: .underReview)
        }
        
        cell!.selectionStyle = .none
        cell!.backgroundColor = UIColor.backgroundColor
        return cell!
    }
}

extension TeamApplyViewController: JXSegmentedListContainerViewListDelegate {
    func listView() -> UIView {
        return view
    }
    func listViewDidScrollCallback(callback: @escaping (UIScrollView) -> ()) {
        self.listViewDidScrollCallback = callback
    }
    func listScrollView() -> UIScrollView {
        return self.tableView
    }
}
