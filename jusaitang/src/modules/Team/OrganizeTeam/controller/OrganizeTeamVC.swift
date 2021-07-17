//
//  OrganizeTeamVC.swift
//  jusaitang
//
//  Created by Jiehao Zhang on 2021/3/2.
//

import UIKit
import RxSwift
import RxCocoa
import MJRefresh
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationView.removeFromSuperview()
        
        self.tableView.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(headerRefresh))
        headerRefresh()
    }
    
    @objc func headerRefresh() {
        self.viewModel.findAllTeams {[weak self] error in
            if let error = error {
                ErrorAlertView.show(error: error)
                return
            }
            (self?.tableView.mj_header as? MJRefreshNormalHeader)?.endRefreshing()
        }
    }
    
    override func bindViewModel() {
        viewModel.organizeTeamCellVMs.subscribe { [weak self] vms in
            self?.tableView.reloadData()
        }.disposed(by: disposeBag)
    }
    
}

extension OrganizeTeamVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 230
    }
}
 
extension OrganizeTeamVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = try? self.viewModel.organizeTeamCellVMs.value().count {
            return count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrganizeTeamCell", for: indexPath) as! OrganizeTeamCell
        if let viewModel = try? self.viewModel.organizeTeamCellVMs.value()[indexPath.row] {
            cell.bindViewModel(viewModel: viewModel)
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
