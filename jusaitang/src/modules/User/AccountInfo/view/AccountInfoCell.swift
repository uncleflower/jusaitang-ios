//
//  AccountInfoCell.swift
//  jusaitang
//
//  Created by Jiehao Zhang on 2021/3/4.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class AccountInfoCell: UITableViewCell {
    
    var viewModel: AccountInfoCellVM!
    
    var disposeBag = DisposeBag.init()
    
    let title: UILabel = {
        let view = UILabel()
        view.font = UIFont.pf_medium(14)
        view.textColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        return view
    }()
    
    let infoLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.pf_medium(14)
        view.numberOfLines = 0
        view.textColor = UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 1)
        return view
    }()
    
    let arrowView: UIImageView = {
        let view = UIImageView()
        view.isUserInteractionEnabled = false
        view.clipsToBounds = true
        view.image = UIImage(named: "login_arrow")
        return view
    }()
    
    let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexString: "#E5E5E5")
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(title)
        contentView.addSubview(infoLabel)
        contentView.addSubview(arrowView)
        contentView.addSubview(lineView)
        
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeConstraints() {
        title.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
            make.width.lessThanOrEqualTo(60)
            make.height.equalTo(20)
        }
        
        arrowView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-16)
            make.width.lessThanOrEqualTo(5)
            make.height.equalTo(9)
        }
        
        infoLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.trailing.equalTo(arrowView.snp.leading).offset(-5)
            make.width.lessThanOrEqualTo(200)
            make.height.equalTo(20)
        }
        
        lineView.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview()
            make.height.equalTo(0.5)
        }
    }
    
    func bindViewModel(viewModel: AccountInfoCellVM) {
        self.viewModel = viewModel
        title.text = viewModel.title
        viewModel.infoObservable.subscribe(onNext: {[weak self] (text) in
            self?.infoLabel.text = text
        }).disposed(by: disposeBag)
    }
}
