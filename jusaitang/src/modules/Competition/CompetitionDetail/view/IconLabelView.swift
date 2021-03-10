//
//  IconLabelView.swift
//  jusaitang
//
//  Created by Jiehao Zhang on 2021/3/10.
//

import UIKit
import SnapKit

class IconLabelView: UIControl {
    
    let icon: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }()
    
    let titleLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.pf_regular(14)
        view.textColor = UIColor(hexString: "#333333")
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(icon)
        addSubview(titleLabel)
        
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeConstraints() {
        icon.snp.makeConstraints { (make) in
            make.height.width.equalTo(15)
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.height.equalTo(15)
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview()
            make.leading.equalTo(icon.snp.trailing).offset(5)
        }
    }
}
