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
    
    var viewModel: TeamApplyViewModel = TeamApplyViewModel()
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(headerRefresh))
        self.navigationView.removeFromSuperview()
        headerRefresh()
    }
    
    @objc func headerRefresh() {
        self.viewModel.getApplyList { [weak self] error in
            if let error = error {
                ErrorAlertView.show(error: error)
                return
            }
            (self?.tableView.mj_header as? MJRefreshNormalHeader)?.endRefreshing()
        }
    }
    
    override func bindViewModel() {
        viewModel.teamApplyCellViewModels.subscribe { [weak self] vms in
            self?.tableView.reloadData()
        }.disposed(by: disposeBag)
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
        if let count = try? viewModel.teamApplyCellViewModels.value().count {
            return count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TeamApplyCell", for: indexPath) as! TeamApplyCell
        
        if let viewModel = try? viewModel.teamApplyCellViewModels.value()[indexPath.row] {
            cell.bindViewModel(viewModel: viewModel)
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
