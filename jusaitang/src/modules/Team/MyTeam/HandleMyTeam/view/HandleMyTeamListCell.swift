//
//  HandleMyTeamListCell.swift
//  jusaitang
//
//  Created by Jiehao Zhang on 2021/4/24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class HandleMyTeamListCell: UITableViewCell {
    
    let disposeBag = DisposeBag()
    
    let selectImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "unselected_img")
        view.highlightedImage = UIImage(named: "selected_img")
        view.cornerRadius = 8
        return view
    }()
    
    let reasonLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.pf_regular(14)
        view.numberOfLines = 0
        view.textColor = UIColor(hexString: "#333333")
        return view
    }()
    
    let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexString: "#EAEAEA")
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(selectImage)
        addSubview(reasonLabel)
        addSubview(lineView)
        
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeConstraints() {
        selectImage.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
            make.width.equalTo(16)
            make.height.equalTo(16)
        }
        
        reasonLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(selectImage.snp.trailing).offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(20)
            make.centerY.equalToSuperview()
        }
    }
}
