//
//  AlbumSelectionV.swift
//  an-xin-bang
//
//  Created by Jiehao Zhang on 2020/7/25.
//  Copyright © 2020 IdeThink Inc. All rights reserved.
//

import UIKit
import SnapKit

class AlbumSelectionV: UIControl {
    
    let lastImg: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.isUserInteractionEnabled = false
        return view
    }()
    
    let albumName: UILabel = {
        let view = UILabel()
        view.font = UIFont.pf_regular(16)
        view.numberOfLines = 0
        view.textColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        return view
    }()
    
    let imgCount: UILabel = {
        let view = UILabel()
        view.font = UIFont.pf_medium(16)
        view.numberOfLines = 0
        view.textColor = UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 1)
        return view
    }()
    
    let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexString: "#E5E5E5")
        return view
    }()
    
    
    let isSelectedImg: UIImageView = {
        let view = UIImageView()
        view.contentMode = .center
        view.image = UIImage(named: "selected_img")
        view.isHidden = true
        view.isUserInteractionEnabled = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        addSubview(lastImg)
        addSubview(albumName)
        addSubview(imgCount)
        addSubview(lineView)
        addSubview(isSelectedImg)
        
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeConstraints() {
        lastImg.snp.makeConstraints { (make) in
            make.leading.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalTo(45)
            make.height.equalTo(45)
        }
        
        albumName.snp.makeConstraints { (make) in
            make.leading.equalTo(lastImg.snp.trailing).offset(15)
            make.centerY.equalToSuperview()
            make.width.lessThanOrEqualTo(80)
        }
        
        imgCount.snp.makeConstraints { (make) in
            make.leading.equalTo(albumName.snp.trailing).offset(15)
            make.centerY.equalToSuperview()
            make.width.lessThanOrEqualTo(60)
            make.height.equalTo(23)
        }
        
        lineView.snp.makeConstraints { (make) in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(0.5)
        }
        
        isSelectedImg.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview().offset(-20)
            make.centerY.equalToSuperview()
            make.height.equalTo(16)
            make.width.equalTo(16)
        }
    }
    
    func bindViewModel(viewModel: AlbumVM){
        albumName.text = viewModel.title
        imgCount.text = "(\(viewModel.images.count))"
        lastImg.load(asset: viewModel.images.last?.model.asset)
    }
}
