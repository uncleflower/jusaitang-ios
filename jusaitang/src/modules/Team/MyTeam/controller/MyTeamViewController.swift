//
//  MyTeamViewController.swift
//  jusaitang
//
//  Created by Jiehao Zhang on 2021/3/5.
//

import UIKit
import RxSwift
import RxCocoa
import JXSegmentedView

class MyTeamViewController: BaseViewController {
    
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
        tableView.register(MyTeamCell.self, forCellReuseIdentifier: "MyTeamCell")
        view.addSubview(tableView)
    }
    
    override func makeConstraints() {
        super.makeConstraints()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationView.removeFromSuperview()
    }
    
    @objc func goHandleMyTeam() {
        let vc = HandleMyTeamVC()
        vc.hidesBottomBarWhenPushed = true
        App.navigationController?.pushViewController(vc, animated: true)
    }
}

extension MyTeamViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 230
        } else if indexPath.row == 1 {
            return 180
        }
        
        return 230
    }
}

extension MyTeamViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyTeamCell", for: indexPath) as! MyTeamCell
        if indexPath.row == 0 {
            cell.reloadData(team: "队伍：小明的队伍", competition: "参加比赛：天梯赛", peopel: "人员：限额10人，7人已报名", position: "身份：队长", showAdminButton: true)
            cell.adminButton.addTarget(self, action: #selector(goHandleMyTeam), for: .touchUpInside)
        } else if indexPath.row == 1 {
            cell.reloadData(team: "队伍：王五的队伍", competition: "参加比赛：数学建模赛", peopel: "人员：限额3人，3人已报名", position: "身份：队员", showAdminButton: false)
        }
        cell.selectionStyle = .none
        cell.backgroundColor = UIColor.backgroundColor
        return cell
    }
}

extension MyTeamViewController: JXSegmentedListContainerViewListDelegate {
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
