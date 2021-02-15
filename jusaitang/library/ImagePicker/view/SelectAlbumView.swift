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
            
    var albumSelectionVs: [AlbumSelectionV] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeConstraints() {
        
        for index in 0 ..< self.viewModels.count {
            if index == 0 {
                albumSelectionVs[index].snp.makeConstraints { (make) in
                    make.top.equalToSuperview()
                    make.leading.equalToSuperview()
                    make.trailing.equalToSuperview()
                    make.height.equalTo(45)
                }
            } else {
                albumSelectionVs[index].snp.makeConstraints { (make) in
                    make.top.equalTo(albumSelectionVs[index-1].snp.bottom)
                    make.leading.equalToSuperview()
                    make.trailing.equalToSuperview()
                    make.height.equalTo(45)
                }
            }
        }
    }
    
    func bindViewModel(viewModels: [AlbumVM]) {
        
        for view in albumSelectionVs{
            view.removeSubviews()
        }
        albumSelectionVs = []
        
        self.viewModels = viewModels
        
        for viewModel in viewModels {
            let albumSelectionV = AlbumSelectionV.init(frame: .zero)
            albumSelectionV.bindViewModel(viewModel: viewModel)
            albumSelectionV.isSelectedImg.isHidden = !viewModel.isSelect
            
            albumSelectionV.addAction {
                self.didSelect?(viewModel)
            }
            
            addSubview(albumSelectionV)
            albumSelectionVs.append(albumSelectionV)
        }
        
        makeConstraints()
    }
}
