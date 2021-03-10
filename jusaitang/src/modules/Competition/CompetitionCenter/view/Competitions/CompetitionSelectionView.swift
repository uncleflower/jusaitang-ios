//
//  CompetitionSelectionView.swift
//  jusaitang
//
//  Created by Jiehao Zhang on 2021/3/3.
//

import UIKit
import SnapKit

class CompetitionSelectionView: UIControl {
    var model: CompetitionSelectionModel!
    
    let imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    let nameLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.pf_semibold(14)
        view.textColor = UIColor(hexString: "#333333")
        return view
    }()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
        addSubview(nameLabel)
        
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeConstraints() {
        imageView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
            make.width.height.equalTo(40)
        }
        
        nameLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(imageView.snp.bottom).offset(7)
            make.height.equalTo(15)
            make.width.lessThanOrEqualTo(60)
        }
    }
    
    func loadData(model: CompetitionSelectionModel) {
        self.model = model
        
        imageView.setImage(url: imageHost + model.imageURL)
        nameLabel.text = model.name
    }
}
