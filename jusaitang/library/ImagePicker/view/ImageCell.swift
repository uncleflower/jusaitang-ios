//
//  ImageCell.swift
//  an-xin-bang
//
//  Created by Jiehao Zhang on 2020/7/25.
//  Copyright © 2020 IdeThink Inc. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class ImageCell: UICollectionViewCell {
    
    var viewModel: ImageVM!
    
    private let disposeBag = DisposeBag()
            
    let imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.isUserInteractionEnabled = false
        return view
    }()
    
    let selectImg: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "unselected_img")
        view.isUserInteractionEnabled = false
        return view
    }()
    
    let surfaceView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.isUserInteractionEnabled = false
        view.alpha = 0
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        contentView.addSubview(selectImg)
        contentView.addSubview(surfaceView)
        
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeConstraints() {
        imageView.snp.makeConstraints { (make) in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        selectImg.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview().offset(-10)
            make.top.equalToSuperview().offset(10)
            make.width.equalTo(16)
            make.height.equalTo(16)
        }
        
        surfaceView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    func bindViewModel(viewModel: ImageVM) {
        self.viewModel = viewModel
        imageView.load(asset: viewModel.model.asset, size:self.imageView.frame.size)
        
        viewModel.isSelectObservable.subscribe(onNext: {[weak self] (isSelected) in
//            self?.selectImg.isHighlighted = isSelected
            self?.selectImg.image = isSelected ? UIImage(named: "selected_img") : UIImage(named: "unselected_img")
            self?.surfaceView.alpha = isSelected ? 0.3 : 0
        }).disposed(by: disposeBag)
    }
}
