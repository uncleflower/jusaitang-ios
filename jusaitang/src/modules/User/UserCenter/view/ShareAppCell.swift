//
//  ShareAppCell.swift
//  jusaitang
//
//  Created by Jiehao Zhang on 2021/3/6.
//

import UIKit

import UIKit
import SnapKit

class ShareAppCell: UICollectionViewCell {
    
    var viewModel: ShareAppCellVM!
    
    let appIcon: UIImageView = {
        let view = UIImageView()
        view.isUserInteractionEnabled = false
        view.clipsToBounds = true
        return view
    }()
    
    let scene: UILabel = {
        let view = UILabel()
        view.font = UIFont.pf_medium(14)
        view.textAlignment = .center
        view.textColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(appIcon)
        contentView.addSubview(scene)
        
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeConstraints() {
        appIcon.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.equalTo(50)
            make.height.equalTo(50)
        }
        
        scene.snp.makeConstraints { (make) in
            make.top.equalTo(appIcon.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.width.lessThanOrEqualTo(60)
            make.height.equalTo(20)
        }
    }
    
    func bindViewModel(viewModel: ShareAppCellVM) {
        self.viewModel = viewModel
        
        appIcon.image = viewModel.image
        scene.text = viewModel.scene.rawValue
    }
}

