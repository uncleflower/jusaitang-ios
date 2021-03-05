//
//  InputWithBar.swift
//  jusaitang
//
//  Created by Jiehao Zhang on 2021/3/4.
//

import UIKit
import SnapKit

class InputWithBar: UIView {
    
    let titleLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.pf_medium(14)
        view.numberOfLines = 0
        view.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        return view
    }()
    
    let inputTextField: UITextField = {
        let view = UITextField()
        view.borderStyle = .none
        view.keyboardType = .default
        view.font = UIFont.pf_medium(14)
        view.textColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        return view
    }()
    
    let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.97, green: 0.97, blue: 0.97, alpha: 1)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white

        
        addSubview(titleLabel)
        addSubview(inputTextField)
        addSubview(lineView)
        
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeConstraints() {
        titleLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview().offset(5)
            make.leading.equalToSuperview().offset(16)
            make.width.lessThanOrEqualTo(70)
            make.height.equalTo(20)
        }
        
        inputTextField.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview().offset(5)
            make.leading.equalToSuperview().offset(87)
            make.trailing.equalToSuperview()
            make.height.equalTo(50)
        }
        
        lineView.snp.makeConstraints { (make) in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalToSuperview()
            make.height.equalTo(5)
        }
    }
}
