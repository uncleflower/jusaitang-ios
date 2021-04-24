//
//  TeamApplyViewController.swift
//  jusaitang
//
//  Created by Jiehao Zhang on 2021/3/5.
//

import UIKit
import RxSwift
import RxCocoa
import JXSegmentedView

class TeamApplyViewController: BaseViewController {
    
    var tableView: UITableView!
    
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
        tableView.register(TeamApplyCell.self, forCellReuseIdentifier: "TeamApplyCell")
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

extension TeamApplyViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}

extension TeamApplyViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TeamApplyCell", for: indexPath) as! TeamApplyCell
        
        if indexPath.row == 0 || indexPath.row == 1 {
            cell.reloadData(nikename: "测试用户", time: "4天前", textContent: "申请加入你的“华迪杯竞赛”队伍", status: .othersApply)
        } else if indexPath.row == 2 {
            cell.reloadData(nikename: "张三", time: "3天前", textContent: "申请加入“ACM竞赛”队伍", status: .agreed)
        } else if indexPath.row == 3 {
            cell.reloadData(nikename: "李四", time: "5天前", textContent: "申请加入“互联网+竞赛”队伍", status: .refused)
        } else if indexPath.row == 4 {
            cell.reloadData(nikename: "王五", time: "10天前", textContent: "申请加入“数学建模竞赛”队伍", status: .underReview)
        }
        
        cell.selectionStyle = .none
        cell.backgroundColor = UIColor.backgroundColor
        return cell
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
