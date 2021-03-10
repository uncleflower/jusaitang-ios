//
//  CompetitionCollectionCell.swift
//  jusaitang
//
//  Created by Jiehao Zhang on 2021/3/4.
//

import UIKit
import SnapKit

class CompetitionCollectionCell: UICollectionViewCell {
    
    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.clipsToBounds = false
        view.cornerRadius = 5
        return view
    }()
    
    let imageView: UIImageView = {
        let view = UIImageView()
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    let competitionNameLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.pf_regular(14)
        view.textColor = UIColor(hexString: "#333333")
        return view
    }()
    
    let competitionLevelLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.pf_semibold(14)
        view.textColor = UIColor.default
        return view
    }()
    
    let competitionTimePlaceLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.pf_regular(12)
        view.textColor = UIColor(hexString: "#666666")
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(containerView)
        containerView.addSubview(imageView)
        containerView.addSubview(competitionNameLabel)
        containerView.addSubview(competitionLevelLabel)
        containerView.addSubview(competitionTimePlaceLabel)
        
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeConstraints() {
        containerView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        imageView.snp.makeConstraints { (make) in
            make.leading.top.trailing.equalToSuperview()
            make.height.equalTo(116)
        }
        
        competitionNameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(imageView.snp.bottom)
            make.leading.equalToSuperview().offset(8)
            make.width.lessThanOrEqualTo(115)
            make.height.equalTo(18)
        }
        
        competitionLevelLabel.snp.makeConstraints { (make) in
            make.top.equalTo(competitionNameLabel.snp.bottom)
            make.leading.equalToSuperview().offset(8)
            make.width.lessThanOrEqualTo(115)
            make.height.equalTo(18)
        }
        
        competitionTimePlaceLabel.snp.makeConstraints { (make) in
            make.top.equalTo(competitionLevelLabel.snp.bottom)
            make.leading.equalToSuperview().offset(8)
            make.width.lessThanOrEqualTo(115)
            make.height.equalTo(16)
        }
        
//        remakeShadow()
    }
    
    func bindViewModel(viewModel: CompetitionCollectionCellVM) {
        guard let model = viewModel.model else {return}
        imageView.setImage(url: imageHost + model.imageURL)
        competitionNameLabel.text = model.name
        
        var level: String = ""
        switch model.level {
        case .college:
            level = "院级比赛"
        case .school:
            level = "校级比赛"
        case .provincial:
            level = "省级比赛"
        case .national:
            level = "国家级比赛"
        default:
            level = "Error"
        }
        competitionLevelLabel.text = level
        
        let time = Date.getDateFromTimeStamp(timeStamp: model.time).toString(dateFormat: "M-d")
        competitionTimePlaceLabel.text = "\(time) \(model.place)"
    }
}
