//
//  FeedbackImgCell.swift
//  jusaitang
//
//  Created by Jiehao Zhang on 2021/3/5.
//

import UIKit
import SnapKit

class FeedbackImgCell: UICollectionViewCell {
    
    var viewModel: FeedbackImgCellVM!
    
    var isEmpty: Bool = false
        
    let feedbackImg: UIImageView = {
        let view = UIImageView()
        view.contentMode = .center
        view.clipsToBounds = true
        view.isUserInteractionEnabled = false
        view.cornerRadius = 3
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(feedbackImg)
        
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeConstraints() {
        feedbackImg.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(5)
            make.trailing.equalToSuperview().offset(-5)
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    func bindViewModel(viewModel: FeedbackImgCellVM) {
        self.viewModel = viewModel
        
        feedbackImg.load(asset: viewModel.model.asset, size: self.frame.size)
    }
    
    func setEmptyImg(img: UIImage) {
        feedbackImg.image = img
        self.isEmpty = true
    }
}
