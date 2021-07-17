//
//  HandleMyTeamListView.swift
//  jusaitang
//
//  Created by Jiehao Zhang on 2021/4/24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class HandleMyTeamListView: UIView {
    
    var tableView: UITableView!
    
    var viewModel: HandleMyTeamViewModel!
    private let disposeBag = DisposeBag()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        tableView = BaseTableView.init(frame: self.frame,style: .plain)
        tableView.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.contentInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
        tableView.layer.cornerRadius = 12
        tableView.separatorStyle = .none
        tableView.register(HandleMyTeamListCell.self, forCellReuseIdentifier: "HandleMyTeamListCell")
        addSubview(tableView)
        
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeConstraints() {
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    func bindViewModel(viewModel: HandleMyTeamViewModel) {
        self.viewModel = viewModel
        
        viewModel.handleMyTeamListCellVMs.subscribe {[weak self] vms in
            self?.tableView.reloadData()
        }.disposed(by: disposeBag)
    }
}

extension HandleMyTeamListView: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 48
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! HandleMyTeamListCell
        // TODO: 踢人
        cell.selectImage.isHighlighted = !cell.selectImage.isHighlighted
    }
}

extension HandleMyTeamListView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = try? viewModel.handleMyTeamListCellVMs.value().count {
            return count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HandleMyTeamListCell", for: indexPath) as! HandleMyTeamListCell
        if let viewModel = try? viewModel.handleMyTeamListCellVMs.value()[indexPath.row] {
            cell.bindViewModel(viewModel: viewModel)
        }
        cell.selectionStyle = .none
        return cell
    }
    
    
}
