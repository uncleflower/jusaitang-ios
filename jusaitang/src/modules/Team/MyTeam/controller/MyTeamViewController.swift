//
//  MyTeamViewController.swift
//  jusaitang
//
//  Created by Jiehao Zhang on 2021/3/5.
//

import UIKit
import RxSwift
import RxCocoa
import MJRefresh
import JXSegmentedView

class MyTeamViewController: BaseViewController {
    
    var tableView: UITableView!
    
    private let disposeBag = DisposeBag()
    
    var listViewDidScrollCallback: ((UIScrollView) -> ())?
    
    var viewModel: MyTeamViewModel = MyTeamViewModel()
    
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
        
        
        tableView.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(headerRefresh))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.headerRefresh()
    }
    
    @objc func headerRefresh() {
        self.viewModel.getMyTeams { [weak self] error in
            if let error = error {
                ErrorAlertView.show(error: error)
                return
            }
            (self?.tableView.mj_header as? MJRefreshNormalHeader)?.endRefreshing()
        }
    }
    
    override func bindViewModel() {
        self.viewModel.myTeamCellVMs.subscribe { [weak self] vms in
            self?.tableView.reloadData()
        }.disposed(by: disposeBag)
    }
}

extension MyTeamViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let model = try? viewModel.myTeamCellVMs.value()[indexPath.row].model {
            if model.isMine {
                return 230
            } else {
                return 180
            }
        }
        return 0
    }
}

extension MyTeamViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = try? viewModel.myTeamCellVMs.value().count {
            return count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyTeamCell", for: indexPath) as! MyTeamCell
        if let viewModel = try? self.viewModel.myTeamCellVMs.value()[indexPath.row] {
            cell.bindViewModel(viewModel: viewModel)
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
