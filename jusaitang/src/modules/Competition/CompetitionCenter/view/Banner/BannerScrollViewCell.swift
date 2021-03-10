//
//  BannerScrollViewCell.swift
//  jusaitang
//
//  Created by Jiehao Zhang on 2021/3/9.
//

import UIKit

class BannerScrollViewCell: CycleScrollViewCell {
    
    var viewModel:BannerItemViewModel?
    
    let imageView: UIImageView = {
        let imgView = UIImageView()
        imgView.isUserInteractionEnabled = false
        imgView.contentMode = .scaleAspectFill
        imgView.clipsToBounds = true
        imgView.cornerRadius = 10
        return imgView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeConstraints() {
        imageView.snp.makeConstraints { (view) in
            view.top.equalToSuperview().offset(10)
            view.leading.equalToSuperview().offset(15)
            view.trailing.equalToSuperview().offset(-15)
            view.bottom.equalToSuperview().offset(-10)
        }
    }
    
    func bindViewModel(viewModel:BannerItemViewModel){
        self.viewModel = viewModel
        imageView.setImage(url: imageHost + viewModel.model.imageURL)
    }
}
