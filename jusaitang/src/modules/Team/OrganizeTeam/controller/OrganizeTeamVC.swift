//
//  OrganizeTeamVC.swift
//  jusaitang
//
//  Created by Jiehao Zhang on 2021/3/2.
//

import UIKit
import RxSwift
import RxCocoa
import JXSegmentedView

class OrganizeTeamVC: BaseViewController {
    
    var tableView: UITableView!
    
    var viewModel = OrganizeTeamVM()
    
    private let disposeBag = DisposeBag()
    
    var listViewDidScrollCallback: ((UIScrollView) -> ())?
    
    override func loadView() {
        super.loadView()
        tableView = BaseTableView.init(frame: self.view.frame,style: .plain)
        tableView.backgroundColor = UIColor.backgroundColor
        tableView.delegate = self
        tableView.dataSource = self
        tableView.contentInset = UIEdgeInsets.init(top: 0, left: 0, bottom: App.tabBarHeight * 3 + App.safeAreaBottom + 10, right: 0)
        tableView.separatorStyle = .none
        tableView.register(OrganizeTeamCell.self, forCellReuseIdentifier: "OrganizeTeamCell")
        view.addSubview(tableView)
    }
    
    override func makeConstraints() {
        super.makeConstraints()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationView.removeFromSuperview()
    }
    
}

extension OrganizeTeamVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 220
        } else if indexPath.row == 1 {
            return 230
        } else if indexPath.row == 2 {
            return 220
        } else if indexPath.row == 3 {
            return 230
        }
        return 230
    }
}

extension OrganizeTeamVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrganizeTeamCell", for: indexPath) as! OrganizeTeamCell
        
        if indexPath.row == 0 {
            cell.reloadData(nikename: "张三", time: "10天前", remainTime: "剩余3天", title: "华迪杯", content: "缺一名安卓开发者，有意向的联系我！", maxCount: 3, curCount: 2)
        } else if indexPath.row == 1 {
            cell.reloadData(nikename: "李四", time: "9天前", remainTime: "剩余5天", title: "天梯赛", content: "缺三名选手，队伍内有一名曾经得过国一的大佬，带飞！", maxCount: 10, curCount: 7)
        } else if indexPath.row == 2 {
            cell.reloadData(nikename: "王五", time: "15天前", remainTime: "剩余10天", title: "数学建模赛", content: "缺一名编程选手，要求会Matlab、python", maxCount: 3, curCount: 2)
            cell.enrollStatView.changeStatusToEnrolled()
        } else if indexPath.row == 3 {
            cell.reloadData(nikename: "测试用户", time: "30天前", remainTime: "剩余5天", title: "互联网+", content: "项目一款家庭音乐软件，有成熟的设计图，缺iOS开发者", maxCount: 7, curCount: 5)
        }
        
        
        cell.backgroundColor = UIColor.backgroundColor
        cell.selectionStyle = .none
        
        return cell
    }
}

extension OrganizeTeamVC: JXSegmentedListContainerViewListDelegate {
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
