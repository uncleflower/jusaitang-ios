//
//  AnnouncementTableViewCell.swift
//  jusaitang
//
//  Created by Jiehao Zhang on 2021/3/10.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class AnnouncementTableViewCell: UITableViewCell {
    var viewModel: AnnouncementCellVM!
    
    let disposeBag = DisposeBag()
    
    let itemView: UIButton = {
        let view = UIButton()
        view.backgroundColor = UIColor(hexString: "#EEEAED")
        view.layer.cornerRadius = 9.5
        view.setTitle("#", for: .normal)
        view.setTitleColor(UIColor(hexString: "#333333"), for: .normal)
        view.titleLabel?.font = UIFont.pf_semibold(12)
        view.isUserInteractionEnabled = false
        view.clipsToBounds = true
        return view
    }()
    
    let contentLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.pf_medium(12)
        view.numberOfLines = 1
        view.textColor = UIColor(hexString: "#333333")
        return view
    }()
    
    let timeLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.pf_medium(12)
        view.numberOfLines = 1
        view.textAlignment = .right
        view.textColor = UIColor(hexString: "#666666")
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(itemView)
        contentView.addSubview(contentLabel)
        contentView.addSubview(timeLabel)
        
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeConstraints() {
        itemView.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(18)
            make.width.equalTo(19)
            make.height.equalTo(19)
            make.centerY.equalToSuperview()
        }
        
        contentLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(itemView.snp.trailing).offset(12)
            make.trailing.equalToSuperview().offset(-50)
            make.height.equalTo(17)
            make.centerY.equalToSuperview()
        }
        
        timeLabel.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview().offset(-15)
            make.width.lessThanOrEqualTo(40)
            make.height.equalTo(17)
            make.centerY.equalToSuperview()
        }
    }
    
    func bindViewModel(viewModel: AnnouncementCellVM) {
        self.viewModel = viewModel
        
        let model = viewModel.model
        contentLabel.text = model?.title
        
        let date = Date(timeIntervalSince1970: TimeInterval(model!.announceAt))
        timeLabel.text = date.toString(dateFormat: "M-d")
    }
}
