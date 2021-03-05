//
//  SelectAlbumView.swift
//  an-xin-bang
//
//  Created by Jiehao Zhang on 2020/7/25.
//  Copyright © 2020 IdeThink Inc. All rights reserved.
//

import UIKit
import SnapKit

class SelectAlbumView: UIView {
    
    var viewModels: [AlbumVM] = []
    
    var didSelect:((AlbumVM?) -> ())? = nil
            
    var albumSelectionVs: [SelectAlbumCell] = []
    
    var tableView: UITableView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .none
        backgroundColor = UIColor(hexString: "#000000", alpha: 0)
        tableView = BaseTableView.init(frame: self.frame,style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundView?.alpha = 0
        tableView.contentInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
        tableView.register(SelectAlbumCell.self, forCellReuseIdentifier: "SelectAlbumCell")
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
    
    func bindViewModel(viewModels: [AlbumVM]) {
        self.viewModels = viewModels
    }
}

extension SelectAlbumView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.didSelect?(viewModels[indexPath.item])
    }
}

extension SelectAlbumView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SelectAlbumCell", for: indexPath) as! SelectAlbumCell
        
        cell.bindViewModel(viewModel: viewModels[indexPath.item])
        cell.selectionStyle = .none
        return cell
    }
    
    
}
