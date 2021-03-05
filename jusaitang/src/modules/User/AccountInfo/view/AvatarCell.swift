//
//  AvatarCell.swift
//  jusaitang
//
//  Created by Jiehao Zhang on 2021/3/4.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class AvatarCell: UITableViewCell {
    
    private let disposeBag = DisposeBag()
    
    var viewModel: AccountInfoCellVM!
    
    let biglineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.97, green: 0.97, blue: 0.97, alpha: 1)
        return view
    }()
    
    let title: UILabel = {
        let view = UILabel()
        view.font = UIFont.pf_medium(14)
        view.textColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        return view
    }()
    
    let avatarView: UIImageView = {
        let view = UIImageView()
        view.isUserInteractionEnabled = false
        view.clipsToBounds = true
        view.cornerRadius = 20
        view.borderWidth = 0.5
        view.borderColor = UIColor(hexString: "#E5E5E5")
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
        contentView.addSubview(avatarView)
        contentView.addSubview(arrowView)
        contentView.addSubview(lineView)
        contentView.addSubview(biglineView)
        
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeConstraints() {
        biglineView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(5)
        }
        
        title.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview().offset(5)
            make.leading.equalToSuperview().offset(16)
            make.width.lessThanOrEqualTo(60)
            make.height.equalTo(20)
        }
        
        arrowView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview().offset(5)
            make.trailing.equalToSuperview().offset(-16)
            make.width.lessThanOrEqualTo(5)
            make.height.equalTo(9)
        }
        
        avatarView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview().offset(5)
            make.trailing.equalTo(arrowView.snp.leading).offset(-5)
            make.width.lessThanOrEqualTo(40)
            make.height.equalTo(40)
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
            self?.avatarView.setImage(url: apiHost + text)
        }).disposed(by: disposeBag)
    }
}
