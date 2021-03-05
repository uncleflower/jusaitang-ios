//
//  MyHeadSelectionView.swift
//  jusaitang
//
//  Created by Jiehao Zhang on 2021/3/4.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class MyHeadSelectionView: UIControl {
    
    let disposeBag = DisposeBag()
    
    let iconView: UIImageView = {
        let view = UIImageView()
        view.isUserInteractionEnabled = false
        view.clipsToBounds = true
        view.cornerRadius = 22.5
        return view
    }()
    
    let titleLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.pf_medium(11)
        view.textAlignment = .center
        view.textColor = UIColor(hexString: "#212321")
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(iconView)
        addSubview(titleLabel)
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeConstraints() {
        iconView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(45)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(iconView)
            make.top.equalTo(iconView.snp.bottom).offset(5)
            make.height.equalTo(16)
        }
    }
}
