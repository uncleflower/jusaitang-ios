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
    
    private let disposeBag = DisposeBag()
    
    var listViewDidScrollCallback: ((UIScrollView) -> ())?
    
    override func loadView() {
        super.loadView()
        tableView = BaseTableView.init(frame: self.view.frame,style: .plain)
        tableView.backgroundColor = UIColor.backgroundColor
        tableView.delegate = self
        tableView.dataSource = self
        tableView.contentInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
        tableView.separatorStyle = .none
//        tableView.register(OrderCell.self, forCellReuseIdentifier: "OrderCell")
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
        return 10
    }
}

extension OrganizeTeamVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.backgroundColor = UIColor.backgroundColor
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
