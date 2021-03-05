//
//  MySelectionView.swift
//  jusaitang
//
//  Created by Jiehao Zhang on 2021/3/3.
//

import UIKit
import SnapKit

class MySelectionView: UIControl {
    
    let selectionImg: UIImageView = {
        let view = UIImageView()
        view.contentMode = .center
        return view
    }()
    
    let selectionLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.pf_semibold(14)
        view.numberOfLines = 0
        view.textColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        return view
    }()
    
    let arrowImg: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "login_arrow")
        view.contentMode = .center
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(selectionImg)
        addSubview(selectionLabel)
        addSubview(arrowImg)
        
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeConstraints() {
        selectionImg.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
            make.width.equalTo(26)
            make.height.equalTo(26)
        }
        
        selectionLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.leading.equalTo(selectionImg.snp.trailing).offset(12)
            make.width.equalTo(60)
            make.height.equalTo(20)
        }
        
        arrowImg.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-16)
            make.width.equalTo(5)
            make.height.equalTo(9)
        }
    }
}
